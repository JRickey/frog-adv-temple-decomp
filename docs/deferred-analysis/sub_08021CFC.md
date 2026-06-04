# sub_08021CFC — deferred analysis (Round 10 Opus escalation: floor 196 → 19)

Entity-array angular-step updater. Operates on one 0x38-byte slot of the
per-actor record array `gEntities[128]` (at `0x03003720`), indexed by `idx`.
Reads/writes the slot's angle counter at +0x10, then advances the slot's
sub-pixel X/Y (+2/+4) along a sine/cosine vector scaled by `mag`, and finally
hands the slot to `sub_080059C4`.

Signature: `void sub_08021CFC(u8 idx, u16 baseX, u16 baseY, s8 mag, u8 mode, u8 delta)`
(`mode`/`delta` are stacked args at `[sp,#40]`/`[sp,#44]`.)

## What changed this round — DO NOT restart from the old 196 base

The prior deferral floored at **byte_diff 196** using a hand-rolled `Actor38`
struct + casted absolute addresses, and concluded the divergence was a
`mag`→`ip` eviction. **That whole diagnosis was an artifact of the wrong
struct.** Re-deriving from scratch with the project's real types reached
**byte_diff 19, diff_count 14** — a true near-match. The four insights that
collapsed 196 → 19 (apply ALL of them; each is load-bearing):

1. **Use the real `struct Entity gEntities[128]`** (include/iwram.h) — NOT a
   hand-rolled struct, NOT casted absolute `0x3720`. `slot->field_10` is the
   angle (u16 @ +0x10); `slot->x`/`slot->y` are +2/+4. With the real struct,
   `mag` STAYS IN r3 (no `ip` eviction at all) — the old 196 plateau vanishes.
2. **Anchor the IWRAM base inside each branch**: `struct Entity *base =
   gEntities; struct Entity *e = base + idx;` (and the same `{ struct Entity
   *base = gEntities; slot = base + idx; }` block before the tail). This makes
   agbcc load the `0x3720` pool word FIRST and compute `idx*0x38` keeping `idx`
   live in r0 (`lsls rN,r0,#3; subs r0,rN,r0`) instead of reloading it via
   `mov rN,r8`. This alone took 224 → 143 → 116.
3. **Cast the sine indices `(s16)angle`**: `sSineTable[(s16)angle]` and
   `sSineTable[(s16)angle - 0x40]`. This restored the mid-function pool (size
   312, exact) and made the cosine index reuse the angle register
   (`subs r4,#64`). Took 116 → 100.
4. **Explicit `s16 sinComp;`/`s16 cosComp;` temps** for the two DFFC results.
   Took 100 → **19**.

`make_check`: still NON-matching (asm slice left in place). The C above is the
"Best-effort C" below; it is clean, readable, early-return-free-of-else, and is
a TRUE near-match — resume from it, do not rebuild.

## The entire residual — one agbcc `force_to_mode` sign-extend decision (×2)

At byte_diff 19, diff_count 14, the function is byte-identical EXCEPT the two
position stores. The diff is the SAME pattern twice (slot->x and slot->y):

```
target  (baserom):  ldr r2,[sp,#0]; lsls r1,r2,#16; asrs r1,r1,#16; adds r1,r1,r0; strh r1,[r7,#2]
built   (ours):     lsls r0,r0,#16; asrs r0,r0,#16; ldr r2,[sp,#0]; adds r0,r0,r2; strh r0,[r7,#2]
```

i.e. for `slot->x = (s16)baseX + sinComp`:
- **baserom** sign-extends `baseX` (the freshly-loaded u16 stack operand) and
  uses the DFFC return (r0) RAW (trusts the s16 return).
- **ours** sign-extends the DFFC return / `sinComp` (the s16 local read) and
  uses `baseX` raw (agbcc's `force_to_mode` proved `(s16)baseX`'s extend
  redundant because the sum is truncated by the `strh`, so it DROPS the baseX
  extend; but the s16-local `sinComp` read is a separate insn combine can't
  reach, so its extend survives — on the wrong operand).

Both forms are numerically identical (low 16 bits equal); it is purely a
register/instruction-selection divergence in agbcc's HImode-store
redundant-sign-extend elimination (`combine.c` `force_to_mode` /
`make_compound_operation`, gated by `nonzero_bits` value tracking).

### Why it does not move (exhaustive — pick a DIFFERENT angle than these)

- **Inline (no temp)** `slot->x = (s16)baseX + sub_0800DFFC(...)`: drops BOTH
  extends (size 304, 8 bytes short — missing exactly the two baseX extends).
  100/22.
- **`s16` temps**: extends the temp/return, drops baseX. **19/14 (BEST).**
- **`u16` temps / `s32` temps / `int` temps / int DFFC prototype**: 19/14
  (size 312) or worse (s32/int grow the stack frame to 316). No flip.
- **Operand order** (`sinComp + (s16)baseX` vs `(s16)baseX + sinComp`),
  `(s32)(s16)baseX`, `(s16)(baseX & 0xFFFF)`, `(s16)(u16)baseX`,
  outer `(s16)(... )` cast, `slot->x = DFFC(); slot->x += (s16)baseX;` (304,
  loses cos reuse), `s32 t = (s16)baseX` block temp (320, frame grows): all
  19/14 or worse. agbcc's `nonzero_bits` sees through every cast.
- **`s16 px = baseX` BEFORE the call + inline DFFC**: store pattern becomes
  CORRECT (`lsls r4,#16; asrs r4,#16; adds r4,r4,r0`, baseX extended, return
  trusted!) but `px` computed pre-call needs a callee-saved reg across the
  call, which perturbs the ENTIRE tail allocation → 165/70. The right pattern,
  wrong placement. **NEXT IDEA: find a source shape that loads+extends baseX
  AFTER the call (as the baserom does) without re-extending the return — that
  is the exact missing trick.**
- **CFLAGS** (all ≥ 19, most worse): `-fforce-addr` (introduces a wrong
  `mov ip,r3` mag eviction → 207/66 then mag→ip), `-fno-gcse`/-`fno-expensive-
  optimizations`/`-fno-cse-follow-jumps` (break the baseX/baseY stack spill →
  275/88 size 300), `-fno-strength-reduce`, `-frerun-cse-after-loop`,
  `-fforce-mem`, `-fno-thread-jumps`, `-fno-cse-skip-blocks`,
  `-fno-rerun-cse-after-loop` (182+). agbcc 2.x has NO flag to disable the
  redundant-sign-extend elimination specifically.
- **Compiler swap**: `CC = $(AGBCC_BIN)` (newer agbcc) makes the temps version
  200/63 (it deduplicates the mid-pool → size 308, wrong) — OLD_AGBCC (the
  Makefile default) is correct for this TU (size 312, 19/14).
- **decomp-permuter**: base score 260 (scorer overweights the register
  renames). 800+ iterations, `perm_cast_simple/commutative/temp_for_expr/
  split_assignment/add_sub/randomize_internal_type` weighted up — stuck at 200
  (a cosmetic `new_var = sSineTable` rename), NEVER approached 0. The
  sign-extend flip is a `force_to_mode` decision, NOT reachable by statement/
  cast mutation. Permuter is the WRONG tool here; do not re-run it.

### Recommended next angle

1. **Instrument agbcc** (private debug copy ONLY — never touch the shared
   symlinked `tools/agbcc`/`tools/agbcc-src`): add an fprintf at the
   `force_to_mode` / `make_compound_operation` site in
   `tools/agbcc-src/gcc_arm/combine.c` that decides to drop the `(s16)baseX`
   sign_extend, compile ONLY this TU with it, and watch why the baseX extend is
   dropped but the baserom keeps it. The goal: a source shape that makes
   baseX's `nonzero_bits` unknown at the add (so the extend is kept) WITHOUT
   re-extending the trusted DFFC return and WITHOUT perturbing the tail
   allocation (the `s16 px` pre-call experiment proved the target codegen IS
   reachable — it just needs the load+extend AFTER the call).
2. **Toolchain hypothesis**: the baserom keeps a redundant sign-extend that
   BOTH our agbcc point-releases drop. The matching build may be a different
   agbcc with a less aggressive `force_to_mode`. Check whether sibling
   functions in this TU also show "kept redundant `(s16)` extend on a u16 stack
   arg added to a trusted call return" — if a cluster shares it, a per-TU
   compiler swap is the real key, not source structure.

## Best-effort C (byte_diff 19, diff_count 14, structurally a TRUE near-match)

```c
#include "game.h"
#include "iwram.h"
#include "types.h"

extern s16 sub_0800DFFC(s16 a, s16 b);
extern void sub_080059C4(void *p);
extern const s16 sSineTable[320];

void sub_08021CFC(u8 idx, u16 baseX, u16 baseY, s8 mag, u8 mode, u8 delta)
{
    struct Entity *slot;
    s32 angle;
    s16 sinComp;
    s16 cosComp;

    if (mode == 1) {
        struct Entity *base = gEntities;
        struct Entity *e = base + idx;
        if (e->field_10 == 0xFF)
            e->field_10 = 0;
        e->field_10 += delta;
        if ((s16)e->field_10 > 0xFF)
            e->field_10 = 0xFF;
    } else if (mode == 0) {
        struct Entity *base = gEntities;
        struct Entity *e = base + idx;
        if ((s16)e->field_10 == 0)
            e->field_10 = 0xFF;
        e->field_10 -= delta;
        if ((s16)e->field_10 < 0)
            e->field_10 = mode;  /* agbcc 0-alias: mode is 0 on this path */
    }

    {
        struct Entity *base = gEntities;
        slot = base + idx;
    }
    angle = slot->field_10;
    if ((s16)slot->field_10 - 0x40 < 0)
        angle = (u16)(angle + 0xFF);

    angle = (s16)angle;
    sinComp = sub_0800DFFC(sSineTable[(s16)angle], mag);
    slot->x = (s16)baseX + sinComp;

    cosComp = sub_0800DFFC(sSineTable[(s16)angle - 0x40], mag);
    slot->y = (s16)baseY + cosComp;

    if ((gIwram_35E0._field_10 & 2) && idx == gIwram_35E0._field_D) {
        gEntities[0].x = slot->x;
        gEntities[0].y = slot->y;
    }

    sub_080059C4(&gEntities[idx]);
}
```
