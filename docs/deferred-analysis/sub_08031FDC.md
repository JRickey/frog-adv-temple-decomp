# sub_08031FDC — deferred (sharp register-coloring local minimum)

`SoundRequestSlot` finalizer: gate on `request->flags & 3 == 3`, clear the low
two bits, then (unless `mode == 0`) walk `gpSoundSystem->count + 4` drain
entries retiring each live one, then clear `startIndex` and return 1.
Verdict: ATTEMPT_MATCH (classify_unmatchable). NOT a NAKED candidate.

The C is structurally CORRECT — control flow, loop, both callees, every struct
access, and the early-return placement all match. The whole residual byte_diff
is ONE robust agbcc register-allocation decision; see Drift.

## Drift

- **Best byte_diff: 141, diff_count 61** with the "## Best-effort C" below
  compiled `-ffixed-r9` (per-TU `src/system/sub_08031fdc.s: CFLAGS += -ffixed-r9`).
  Without `-ffixed-r9` the prologue mis-allocates `mode` to r9 (byte_diff 152).
- **The single divergence: `&gpSoundSystem` (the constant address 0x030065e0)
  lands in callee-saved `r7` (saved once: `adds r7, r3, #0`) in every candidate;
  the baserom keeps it in `ip` and REMATERIALIZES it from the literal pool after
  each `bl` (`ldr r2,[pc]; mov ip, r2` at 0x32062).** Because the address takes
  r7, `mode` and the zero-constant get bumped, producing the entire
  ARGUMENT_MISMATCH cascade. Fix the address→ip and the whole diff collapses.
- **Root cause (confirmed across ~15 source shapes + ~20 flag combos):** the
  baserom occupies ALL of r4-r7 with loop values — `r4=i`, `r5=byteIdx (stride
  12)`, `r6=req+0x110 (drain-array field anchor, reloaded each iter)`,
  `r7 = 0 (the store constant, live across the inner bl)` — and `r8=mode`. With
  no spare callee-saved reg, the address-pseudo is forced to `ip` and reloaded.
  agbcc on this tree instead REMATERIALIZES the `0` constant (REG_EQUIV to
  CONST_INT 0) at each store, which FREES r7, and the allocator then prefers
  call-saved r7 for the address (referenced ≥3×) over per-use reload. I could
  not make the literal `0` claim r7 from clean C — it is always rematerializable.

### Levers tried (none flipped address→ip)
- Source shapes: direct `gpSoundSystem` macro; `gpsp = &gpSoundSystem` local;
  cached `ss = gpSoundSystem`; explicit `drainBase = &request->nextRegion`
  anchor; re-reading `SOUND_REQUEST_DRAIN_ENTRIES(request)[i]` inside the loop
  vs a cached base; `while` + nested `if` vs `for` + `continue`; a single reused
  `zero` var (s32 / u32* / u8-cast); `zero` born before the flags check and also
  used for `startIndex`.
- `register zero asm("r7")` pin: agbcc honored it only for zero's (short) live
  range, then REUSED r7 for the address → semantically wrong stores. Dead end.
- Flags (all with `-ffixed-r9`): `-fforce-addr`, `-fno-gcse`,
  `-fno-cse-follow-jumps`, `-frerun-cse-after-loop`, `-fno-rerun-cse-after-loop`
  (splits the address into TWO pool loads — worse), `-fno-rerun-loop-opt`,
  `-fno-expensive-optimizations`, `-fno-caller-saves`/`-fcaller-saves`,
  `-fno-strength-reduce`, `-fno-schedule-insns(2)`, `-fno-move-all-movables`,
  `-fno-function-cse`, `-O1` (wrong shape — no high regs), `-ffixed-r7` (frees r7
  but breaks the loop-value allocation). Newer agbcc (`AGBCC_BIN`): identical.
- decomp-permuter (-ffixed-r9 scratch, ~175 iters): base score 3490, best 3170
  (≈ byte_diff 130). It mutates scope/order only and cannot flip the allocator's
  call-saved preference — stuck in the same minimum. (No leaked workers.)
- Corpus history search `mov +ip, r[0-7]`: the `mov ip` hits (mzm audio) are
  value-into-ip stores, not the "reload pool-constant address into ip across bl"
  idiom; no usable pairing.

### Next agent: try
- Instrument agbcc `local-alloc.c` / `global.c` hard-reg assignment for the
  address-pseudo (why it prefers call-saved r7 over ip+remat) — the cost model
  is the lever; a private debug build can confirm which weight to tip.
- A source construction that makes the literal `0` store NON-rematerializable so
  it genuinely claims r7 (forcing the address to ip). Laundering 0 through a
  non-constant runtime expression without changing semantics is the open
  problem.

## Best-effort C

```c
#include "sound.h"

extern void sub_0802F9F0(s32 idx);
extern void sub_0802E724(s32 ch);

/* Needs per-TU `src/system/sub_08031fdc.s: CFLAGS += -ffixed-r9` to get the
 * mode-in-r8 prologue. byte_diff 141 — the only residual is &gpSoundSystem in
 * callee-saved r7 vs the baserom's ip-rematerialized. See ## Drift. */
u32 sub_08031FDC(u32 mode)
{
    SoundRequestSlot *request;
    s32 i;

    request = gpSoundSystem->slot;

    if ((request->flags & 3) != 3)
        return 0;

    request->flags &= ~3;

    if (mode == 0)
        goto done;

    for (i = 0; i < (s32)gpSoundSystem->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT; i++) {
        if (SOUND_REQUEST_DRAIN_ENTRIES(request)[i].live == 0)
            continue;

        if (mode == 1) {
            sub_0802F9F0(i);
        } else {
            gpSoundSystem->channelSeqs[i].opPtr = NULL;
            sub_0802E724(i);
        }
        SOUND_REQUEST_DRAIN_ENTRIES(request)[i].live = 0;
    }

done:
    gpSoundSystem->startIndex = 0;
    return 1;
}
```
