# sub_08031FDC — deferred (CALLER_SAVE_PROFITABLE register-coloring minimum)

`SoundRequestSlot` finalizer. `request = gpSoundSystem->slot`; gate on
`(request->flags & 3) == 3`; clear the low two bits; then (unless `mode == 0`)
walk `gpSoundSystem->count + 4` drain entries, retiring each live one (mode==1 →
`sub_0802F9F0(i)`; else clear `channelSeqs[i].opPtr` + `sub_0802E724(i)`), clear
each `.live`; finally clear `startIndex` and return 1. Else return 0.
Verdict: ATTEMPT_MATCH (classify_unmatchable). NOT a NAKED candidate.

The C is STRUCTURALLY CORRECT — control flow, loop, byteIdx strength-reduction,
drainBase anchor (`&request->nextRegion` = request+0x110), both callees, every
struct access, the `==3`/`!=0`/`==1` branch directions, and the early-return tail
all match. The residual is ONE robust agbcc register-allocation decision.

## Best byte_diff: 107, diff_count 47 (the "## Best-effort C" below, NO levers)

This is a clean pure-C result, down from the prior note's 141. Levers (flags,
pins) all made it WORSE or introduced miscompiles — see below. Do NOT tweak this
near-match; the blocker is structural to agbcc's allocator.

## Root cause (confirmed by instrumenting agbcc gcc/global.c on THIS tree)

The single divergence: `&gpSoundSystem` (constant 0x030065e0) lands in a
callee-saved register; the baserom keeps it in `ip` and rematerializes it from
the pool after each `bl` (`ldr rN,[pc]; mov ip,rN`).

I built a private debug `old_agbcc` with an fprintf at the `find_reg` hard-reg
assignment in `gcc/global.c` and read the live allocno data for this function:

  pseudo  meaning     n_refs calls live_len  ->  hardreg
  36      i            14     2    80          r4
  105     byteIdx       9     2    68          r5
  29      drainBase     5     2    40          r6
  22      mode          4     2    62          r7   (baserom: r8)
  57      zero          5     2    84          r8   (baserom: r7)
  23      &gpSoundSystem 6     2   124          r9   (baserom: ip)

The address (pseudo 23) is allocated LAST (lowest priority: largest live_len).
`find_reg` reports `best_reg<0` for it (no callee-saved reg free among r4-r8 at
that point — GOOD, this is the baserom condition). It THEN tries the caller-saves
path (which would give `ip`), but:

  CALLER_SAVE_PROFITABLE(REFS, CALLS) = (4*CALLS < REFS)   [regs.h:218]
  = (4*2 < 6) = (8 < 6) = FALSE

So caller-save is NOT taken; it falls through to the "kick out poorly-used local
regs" path and grabs r9. **The address needs n_refs >= 9 (with calls=2) for
`ip`.** But the priority formula `allocno_compare` is
`floor_log2(n_refs)*n_refs / live_len`: at n_refs=9, live_len=124 the priority
(27/124≈0.22) EXCEEDS mode (8/62≈0.13) and zero (≈0.14), so the address would be
allocated EARLY and take a LOW callee-saved reg (r4/r5) instead of falling to
caller-save. Verified: routing channelSeqs through pPool raises refs to 8 and the
address takes r7 directly (no best_reg<0). The two conditions
(profitable AND last-allocated) are in direct tension and no source shape tried
satisfies both. For both to hold need n_refs>=9 AND live_len>~209 (≈2x current).

## Levers tried (none reached ip cleanly)

- `-ffixed-r7`, `-ffixed-r9`, `-ffixed-r9 -ffixed-r10`, `-ffixed-sl`: ALL IGNORED
  by this agbcc thumb backend (objdump confirms the address still lands in the
  "forbidden" reg). r7 is FRAME_POINTER_REGNUM (thumb.h:637) — special. Do not
  rely on -ffixed-rN for register coercion on this title.
- `-fno-gcse`, `-fno-cse-follow-jumps`, `-fno-expensive-optimizations`,
  `-fforce-addr`(+combos), `-fno-strength-reduce`, `-frerun-cse-after-loop`: all
  byte_diff 107 (no effect).
- `register SoundSystem **pPool asm("ip")`: DOES put the address in ip (good!),
  but (a) forces `mov ip` to the TOP before the slot read (baserom defers it
  until after slot, as a caller-save side effect), and (b) mode/zero land r7/r8
  swapped → byte_diff 156. Adding `mode asm("r8")` → 111. Adding `zero asm("r7")`
  on top → MISCOMPILE (`cmp sp, r0` for the guard; r7 dropped from the prologue
  push). Pins are a dead end here.
- `zero asm("r7")` alone (prior note's lever): agbcc honors it only for zero's
  short range then reuses r7 for the address. Confirmed dead end.
- Source shapes: pPool ptr-to-ptr vs bare `gpSoundSystem` macro (137);
  for-loop vs guard+do-while sibling shape (sub_0802D8F8) (144, diff_count 44 but
  more bytes); channelSeqs via fresh macro load (107, BEST — keeps it a separate
  pool load matching baserom 0x32044) vs via pPool (8 refs → address grabs r7);
  fresh count-check load (creates a 7th pseudo → r10, 169); explicit `request +
  0x110` cast for drainBase (no change — the offset fold is RTL-level).

## Secondary diff (independent of the address issue)

The drainBase offset 0x110 is built as `adds r0,#20` reusing the live `0xfc`
flags-clear constant (`0xfc + 0x14 = 0x110`) instead of the baserom's fresh
`movs r2,#136; lsls r2,#1`. This is an agbcc CSE fold of the REG_EQUIV constant
0xfc; not movable by any flag or offset-expression shape tried. Likely resolves
once the register layout matches (the baserom keeps request in callee-saved r5,
so 0xfc is not live at the drainBase computation in the original).

## Next agent: try
- The calls_crossed=1 path: if the address can be made DEAD across one of the two
  (mutually-exclusive) calls, `4*1 < 6` is TRUE → caller-save → ip. The blocker
  is the loop-BOTTOM count recheck keeping the address live across the whole body
  (calls=2). A structure that reloads the address fresh at the bottom check
  WITHOUT spawning a 7th register-resident pseudo is the open problem.
- A construction that lengthens the address live_len to >~209 while pushing
  n_refs to exactly 9 (loop-weighted) so it stays lowest-priority AND profitable.
- decomp-permuter is NOT indicated (byte_diff 107 >> 40; it mutates scope/order,
  cannot flip the caller-save cost decision — same minimum the prior note hit).

## Best-effort C

```c
#include "sound.h"

extern void sub_0802F9F0(u32 idx);
extern void sub_0802E724(s32 ch);

/* byte_diff 107, diff_count 47, NO levers. Residual: &gpSoundSystem lands in a
 * callee-saved reg (r9) instead of the baserom's ip-rematerialized. See
 * ## Root cause — CALLER_SAVE_PROFITABLE(refs,2) needs refs>=9, which conflicts
 * with the allocation priority needed to fall through to caller-save. */
u32 sub_08031FDC(u32 mode)
{
    SoundSystem **pPool = &gpSoundSystem;
    SoundRequestSlot *request = (*pPool)->slot;
    u8 **drainBase;
    SoundDrainEntry *drain;
    u8 flags = request->flags;
    s32 i;

    if ((flags & 3) == 3) {
        request->flags = flags & ~3;

        if (mode != 0) {
            u32 zero = 0;

            drainBase = &request->nextRegion;
            for (i = 0; i < (s32)(*pPool)->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT; i++) {
                drain = (SoundDrainEntry *)*drainBase;
                if (drain[i].live == 0)
                    continue;

                if (mode == 1) {
                    sub_0802F9F0(i);
                } else {
                    gpSoundSystem->channelSeqs[i].opPtr = (u32 *)zero;
                    sub_0802E724(i);
                }

                drain = (SoundDrainEntry *)*drainBase;
                drain[i].live = zero;
            }
        }

        (*pPool)->startIndex = 0;
        return 1;
    }

    return 0;
}
```
