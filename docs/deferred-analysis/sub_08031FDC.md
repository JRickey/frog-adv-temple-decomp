# sub_08031FDC — deferred (agbcc caller-save of &gpSoundSystem into ip)

`SoundRequestSlot` finalizer. `request = gpSoundSystem->slot` (offset 0x118);
gate on `(request->flags & 3) == 3`; clear the low two bits; then (unless
`mode == 0`) walk `gpSoundSystem->count + 4` drain entries (drainBase =
`&request->nextRegion`, offset 0x110; stride 12, `.live` at +4), retiring each
live one (mode==1 → `sub_0802F9F0(i)`; else clear
`gpSoundSystem->channelSeqs[i].opPtr` (offset 0x114, stride 16) + `sub_0802E724(i)`);
clear each `.live`; finally clear `startIndex` (offset 0x1) and return 1. Else 0.
Verdict: ATTEMPT_MATCH. NOT a NAKED candidate.

NOTE on struct offsets: the header (`include/sound.h`) is CORRECT for agbcc
(32-bit pointers): slot=0x118, channelSeqs=0x114, nextRegion=0x110,
SoundChannelSeq=16B, SoundDrainEntry=12B. Do NOT verify offsets with host gcc
(64-bit pointers double every pointer-containing struct — gives 0x150/0x148/0x220,
which is WRONG for this target). Compile a probe with agbcc, or trust the header.

## Best byte_diff: 20 (diff_count 20) — MAJOR improvement over the prior 107 plateau

This round RE-DERIVED the structure from scratch and found the C shape that puts
`&gpSoundSystem` into `ip` (caller-save) like the baserom — the thing the prior
two notes said was unreachable. The breakthrough was THREE moves together:

1. **Pin `&gpSoundSystem` to `ip`** (`register SoundSystem **pPool asm("ip");`)
   AND **manually reload it after the call**: assign `pPool = &gpSoundSystem;`
   inside the `if (drain[i].live != 0)` block (after both mutually-exclusive
   calls). This reproduces the baserom's caller-save rematerialization at 32062
   (`ldr r2,[pc]@0x32084; mov ip,r2`) — verified the not-live path correctly
   SKIPS the reload (baserom `beq 0x32066`, past the `mov ip`). Without this
   reassignment the pinned ip is held live across the call (semantically wrong AND
   byte-divergent). WITH it, the loop body + reload + tail are STRUCTURALLY
   IDENTICAL to the baserom.
2. **Pin `mode` to `r8`** (`register u32 modeReg asm("r8") = mode;`). The baserom
   keeps mode in r8; without the ip pin freeing the address from a callee-saved
   reg, mode lands in r7 and `zero` in r8 (swapped). The ip pin frees r9 entirely
   (only ONE high reg saved, matching baserom's `mov r7,r8; push{r7}`).
3. **Defer the `mov ip`**: read slot via a SEPARATE `addr = &gpSoundSystem` var
   (then `pPool = addr;` after the flags work), NOT via the pinned `pPool`
   directly. Reading slot through `pPool` forces `mov ip` to the TOP (byte 113+);
   the separate `addr` defers it to after the ands (matching baserom 31ffa).
4. **`i = flags & 3; if (i == 3)`** — reuse the loop var `i` to hold the
   flags-AND result. This is the agbcc idiom that colors the flags test into the
   right register (drops byte_diff 25→22). It reads ugly but is load-bearing;
   a clean `if ((flags&3)==3)` regresses to byte_diff 30.
5. **`register SoundSystem **addr asm("r0")`** — pins the address constant to r0
   so the prologue's const/deref register numbering matches (byte_diff 22→20:
   fixes the entire `ldr r0,[pc]` / `ldr r1,[r0]` / `ldr r5,[r1]` chain + the
   flags-test reg + the deferred `mov ip,r0`).

The prologue through 0x24 and the loop body STRUCTURE (incl. the conditional ip
reload) are now byte-identical.

## The residual 20 bytes: agbcc SCRATCH-register tie-breaks (the new wall)

Every remaining diff is an `rN`-vs-`rM` opcode-identical tie-break, NOT a
structural difference. They cluster:
- `flags & ~3`: baserom `movs r0,#252; ands r0,r2; strb r0` (result r0, reusing
  the const's just-freed reg); mine `ands r2,r0; strb r2` (result r2, reusing the
  dying `flags` operand). Commutative-AND destination tie-break.
- count check: baserom `mov r1,ip; ldr r0,[r1]` (ip→fresh r1, deref→r0); mine
  `mov r0,ip; ldr r0,[r0]` (reuses r0). ip-copy temp selection.
- 0x110 const (`movs #136`): baserom r2, mine r0.
- 0x114 const (`movs #138`): baserom r1, mine r2.
- `mode==1` test: baserom `mov r0,r8`, mine `mov r1,r8`. modeReg-read temp.
- ip-reload at the tail: baserom `ldr r2,[pc]; mov ip,r2`, mine `ldr r0; mov ip,r0`.

Root cause: the baserom consistently uses r0 as the "most-recently-freed" scratch
(r0 is freed by `mov ip, r0` and reused immediately), and r1/r2 for ip-copies.
The `addr asm("r0")` pin gets the const into r0 for the prologue but POISONS r0
for the body scratch (agbcc treats the pinned reg as specially owned and avoids
it for the commutative-AND result etc.). Removing the addr pin (byte 22) un-poisons
r0 but reverts the prologue numbering — the two are in tension. These tie-breaks
are below the granularity of C-level control.

## Levers tried this round (all plateaued at byte 20–22)
- Pin combos: {mode r8} alone (116/40); {mode r8 + pPool ip}, mov-ip-deferred via
  `addr` + manual reload (32→25 with literal `0`→22 with `i`-reuse→20 with
  `addr` r0 pin). {ss deref asm("r1")} → 27 (pushes const to r2, worse).
- Loop shapes: for-loop (107 base), do-while+guard (best — drainBase set after the
  entry test, matching baserom), while+macro-count (137, splits the address into
  two pseudos).
- `zero` as a var vs literal `0`: literal `0` is BETTER here (25 vs 32) — the
  baserom's r7=0 register falls out naturally without an explicit `u32 zero`.
- channelSeqs/startIndex/slot: via the `gpSoundSystem` MACRO (fresh pool load), NOT
  through `pPool` — matches the baserom's separate pool literal 0x32084 for
  channelSeqs and the ip path for startIndex.
- permuter: base 115 (byte 20, 3-pin) → plateau ~105 over 16k+ iters; base 115
  (byte 22, 2-pin) → plateau ~115. The pins constrain the mutation space; the
  permuter found the `i=flags&3` reuse and the literal-`0` shape (adopted above)
  but CANNOT flip the scratch-register tie-breaks (no statement reorder changes
  agbcc's commutative-AND dest or ip-copy temp choice). NOT indicated further.

## Root cause of WHY clean (no-pin) C can't reach ip (confirmed by instrumenting
   agbcc gcc/global.c + gcc/regs.h on THIS tree)

The address pseudo (`&gpSoundSystem`, value 0x030065e0) gets refs=6, calls=2,
livelen=124 and lands in **r9** via the global allocator's two-pass loop +
alternate-class fallback. To reach `ip` it must take the CALLER-SAVE path, gated by
`CALLER_SAVE_PROFITABLE(REFS,CALLS) = (4*CALLS < REFS)` [regs.h:218,
global.c:1111]. With CALLS=2 that needs REFS>=9. But REFS only reaches 8 by routing
channelSeqs through pPool, and at REFS>=8 the allocation PRIORITY
(`floor_log2(refs)*refs/livelen`) exceeds mode/zero, so the address is allocated
EARLY and grabs a low callee-saved reg (r7) instead of falling through to
caller-save. The two conditions (last-allocated AND profitable) are in direct
tension; need REFS>=9 AND livelen>~227 (≈2x current) simultaneously — no source
shape achieves both. CONFIRMED: forcing `CALLER_SAVE_PROFITABLE` to always-true in
a private debug agbcc does NOT produce ip (the address still finds a free
callee-saved reg via the two-pass loop before the caller-save block is even
reached — `best_reg<0` is required first, and r9 is available in our lower-pressure
function). The baserom's compile had r9 unavailable / higher pressure so the
address fell to caller-save naturally. We can only force it via the ip pin.

## Next agent: the open problem is the SCRATCH tie-break, not the address

The hard part (address→ip) is SOLVED by the pin recipe above (byte 20). The
remaining 20 bytes are pure agbcc scratch-register tie-breaks. Ideas to try:
- A 4th pin is risky (cascades), but a targeted pin on the count-check ip-copy
  temp or the `flags&~3` result might close specific diffs — try one at a time and
  watch for cascade.
- Investigate whether the `addr asm("r0")` pin can be DROPPED while keeping the
  const in r0 naturally (the un-poisoning route): find a deref structure where
  agbcc loads the const into r0 and the `*addr` deref into r1 WITHOUT a pin. In
  Variant Y (unpinned) agbcc does the opposite (const r1, deref r0). The birth
  order of the two loads decides it — a construction that makes the const "born"
  before the deref into r0 would un-poison the body scratch AND fix the prologue.
- Instrument gcc/local-alloc.c / reload.c (NOT global.c — the scratch temps are
  local/reload-level, below the global allocator) to see why the commutative-AND
  picks the flags operand's reg vs the constant's reg.

## Best-effort C (byte_diff 20, diff_count 20)

```c
#include "sound.h"

extern void sub_0802F9F0(u32 idx);
extern void sub_0802E724(s32 ch);

/* byte_diff 20. &gpSoundSystem reaches ip (caller-save) via the ip pin + manual
 * reload; residual is agbcc scratch-register tie-breaks (commutative-AND dest,
 * ip-copy temp). See ## The residual 20 bytes. */
u32 sub_08031FDC(u32 mode)
{
    register u32 modeReg asm("r8") = mode;
    register SoundSystem **pPool asm("ip");
    register SoundSystem **addr asm("r0") = &gpSoundSystem;
    SoundSystem *ss = *addr;
    SoundRequestSlot *request = ss->slot;
    u8 **drainBase;
    SoundDrainEntry *drain;
    u8 flags = request->flags;
    s32 i;

    i = flags & 3;          /* reuse i to color the flags-AND result (agbcc idiom) */
    pPool = addr;

    if (i == 3) {
        request->flags = flags & ~3;

        if (modeReg != 0) {
            i = 0;
            if (i < (s32)(*pPool)->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT) {
                drainBase = &request->nextRegion;

                do {
                    drain = (SoundDrainEntry *)*drainBase;
                    if (drain[i].live != 0) {
                        if (modeReg == 1) {
                            sub_0802F9F0(i);
                        } else {
                            gpSoundSystem->channelSeqs[i].opPtr = (u32 *)0;
                            sub_0802E724(i);
                        }
                        drain = (SoundDrainEntry *)*drainBase;
                        drain[i].live = 0;
                        pPool = &gpSoundSystem;   /* manual caller-save reload of ip */
                    }
                    i++;
                } while (i < (s32)(*pPool)->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT);
            }
        }

        (*pPool)->startIndex = 0;
        return 1;
    }

    return 0;
}
```
