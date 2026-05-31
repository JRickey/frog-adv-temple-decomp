# sub_0800CED0 — deferred analysis

Range `[0x0800ced0, 0x0800cf94)` (the asm slice `asm/disasm_0x0800ced0.s` was
peeled too WIDE — it also contained a SECOND function `sub_0800CF9C` at
`[0x0800cf9c, 0x0800cfdc)`). The slice should be split: `sub_0800CF9C` lives in
its own `asm/disasm_0x0800cf9c.s` slice; only `sub_0800CED0` is the decomp
target here.

## Semantics (fully reverse-engineered — algorithm is CONFIRMED correct)

Point-in-expanded-rectangle test on two packed 16.16 / s16x2 values.

Params: `(struct Rect2 *s, s32 a, s32 b, s16 c, s16 e)` where `e` is the 5th arg
(read from `[sp,#28]` after the `{r4-r7,lr}` + `{r6,r7}` pushes = arg slot 4).

- `a` packs two s16 lanes: `a.HI` (an X coord), `a.LO` (a Y coord).
- `b` packs two s16 lanes: `b.HI` (a height), `b.LO` (a width).
- `c` is an X-margin, `e` a Y-margin.

Computed box (each lane independently, clamped to >= 0):
- `x0 = max(0, (s16)a.HI - c)`
- `y0 = max(0, (s16)a.LO - e)`
- `w  = (s16)(b.LO + 2*c)`
- `h  = (s16)(b.HI + 2*e)`

Returns 1 iff `s->_field_2` (rectX) in `[x0, x0+w]` AND `s->_field_4` (rectY) in
`[y0, y0+h]` (inclusive: `<`/`>` fail, so closed interval). Else 0.

The lane manipulation in asm is explicit 32-bit masking with pool constants
`0xffff0000` (himask) and `0x0000ffff` (lomask) — NOT `.HALF.HI`/`.HALF.LO`
union field writes (those would emit `strh`). So the original C is hand
bit-twiddled 32-bit math.

`struct Rect2 { u16 _field_0; s16 _field_2; s16 _field_4; }` (rectX at +2, rectY
at +4) — same struct as the sister `sub_0800CFDC` right after it.

## Drift

Best achieved: **byte_diff 167, diff_count 96** (Thumb instr-level). The
ALGORITHM matches; this is pure register-coloring drift. The prologue
(`push {r4-r7,lr}; mov r7,r9; mov r6,r8; push {r6,r7}`) and epilogue
(`pop {r3,r4}; mov r8,r3; mov r9,r4; pop {r4-r7}; pop {r1}; bx r1`) MATCH exactly
once `himask` is pinned to r8 and `ee` (= sign-extended e) to r9 as
`register s32 x asm("rN")`.

The ONE unresolved divergence (and its whole cascade):
- **Target keeps the `s` pointer in `ip` (r12)** the entire function, reading
  `s->_field_2`/`_field_4` via `mov r7, ip; ldrsh [r7, ...]` only at the end.
- **agbcc gives `s` a callee-saved low reg `r7` from the start** (`adds r7,r0,#0`
  at offset 0x08). Because r7 is then busy with the pointer (not the `0x0000ffff`
  lomask, which the target parks in r7 and lets die before reusing r7 for the
  pointer), every temp register in the comparison block shifts by one
  (r0/r1/r2/r3 mine vs the target's allocation), producing ~all 96 diffs.

Root cause (read tools/agbcc-src/gcc_arm/{local-alloc,regclass}.c next): agbcc's
allocator does NOT CSE the `0x0000ffff` lomask into a callee-saved low reg — it
reloads it into r4 at each use — so r7 never gets claimed by lomask and stays
free for the late-used pointer, which agbcc then assigns to r7 instead of ip.
The target's allocator kept lomask live in r7 across the function and reused r7
for the pointer afterward (register coalescing/reuse mine doesn't reproduce).

## Levers already tried (pick a DIFFERENT one next)
- s32 masking, no pins → 156/131 (mask in low reg, no high-reg push).
- working-var (a/b as accumulators), no pins → 96 but NO high-reg push
  (structurally wrong prologue).
- `register s32 himask asm("r8")` + `register s32 ee asm("r9")`, lazy assign,
  `ee` as s32 (NOT s16 — s16 caused a spurious `(u16)` zero-extend) → 97-96,
  CORRECT prologue/epilogue, only the pointer-in-r7-vs-ip cascade remains. THIS
  IS THE BEST BASE (below).
- Triple pin adding `register s32 lomask asm("r7")` → 114-138 (WORSE — pinning
  lomask to r7 keeps it live to function end, blocking r7-reuse for the pointer
  and forcing spills). Do not re-try a naive r7 lomask pin.
- `register struct Rect2 *sp asm("ip")` to force the pointer → 119-172 (WORSE —
  agbcc mishandles an `asm("ip")` pin, inserts spill code).
- Inlining `s->_field_2`/`_field_4` (dropping rx/ry/result locals) → 117 (worse;
  the rx/ry/result locals help).

## Untried ideas for the next attempt
- Get agbcc to keep `0x0000ffff` in r7 *but let it die* before the comparison so
  r7 is reused for the pointer (mirroring the target). Maybe a `register s32
  lomask asm("r7")` whose last textual use is BEFORE the field reads AND a
  separate statement that forces the pointer load to come strictly after — or a
  scratch that re-pins r7 right before the comparison.
- Try `-fno-gcse` / `-fno-cse-follow-jumps` / `-fno-schedule-insns` per-TU
  CFLAGS to change which constant agbcc keeps in a register.
- Cast the dead packed value to force the pointer into ip (the sub_0800A1C8
  index-reuse trick): after the math, `s` is the only live pointer — coax it into
  ip by raising low-reg pressure right at the comparison (e.g. keep `w`,`h`,`x0`,
  `y0` all in low regs simultaneously there).
- Permuter is NOT recommended yet: byte_diff 167 is far outside its ≤40 sweet
  spot even though the structure is right (the drift is whole-function alloc, not
  local scheduling).

## Best-effort C (CORRECT algorithm; best register match = 96 diff)

```c
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct Rect2 {
    u16 _field_0;
    s16 _field_2;
    s16 _field_4;
};

/* old_agbcc TU (sister grid functions all build under old_agbcc). */
u32 sub_0800CED0(struct Rect2 *s, s32 a, s32 b, s16 c, s16 e)
{
    register s32 himask asm("r8");
    register s32 ee asm("r9"); /* s32 (not s16) — s16 adds a spurious (u16) ext */
    s32 va;
    s32 vb;
    s16 x0, y0, w, h;
    s16 rx, ry;
    u32 result;

    ee = e;
    va = (u16)(a - ee);
    himask = 0xffff0000;
    va = (a & himask) | va;
    if ((s16)va < 0)
        va = (va & himask);
    va = (va & 0x0000ffff) | (((s16)(va >> 16) - c) << 16);
    if ((s16)(va >> 16) < 0)
        va = (va & 0x0000ffff);

    vb = (b & himask) | (u16)(b + 2 * c);
    vb = (vb & 0x0000ffff) | (((s16)(vb >> 16) + 2 * ee) << 16);

    x0 = (s16)(va >> 16);
    y0 = (s16)va;
    w = (s16)vb;
    h = (s16)(vb >> 16);

    rx = s->_field_2;
    ry = s->_field_4;

    result = 0;
    if (rx < x0)
        return result;
    if (rx > x0 + w)
        return result;
    if (ry < y0)
        return result;
    if (ry > y0 + h)
        return result;
    result = 1;
    return result;
}
```

## Note for the next agent on the asm-slice split
The asm slice `asm/disasm_0x0800ced0.s` is OVER-WIDE: it spans
`[0x0800ced0, 0x0800cfdc)` and contains BOTH `sub_0800CED0` (the target,
`[0x0800ced0, 0x0800cf94)`, then a 4-byte pool to 0xcf9c) AND a second function
`sub_0800CF9C` (`[0x0800cf9c, 0x0800cfdc)` — a simpler point-in-rect test, sister
of `sub_0800CFDC`). This run left the combined slice intact on revert.

When resuming and landing the match: split the slice — create
`asm/disasm_0x0800cf9c.s` for `sub_0800CF9C`, delete the sub_0800CED0 portion,
add `src/engine/sub_0800ced0.c`, wire `src/engine/sub_0800ced0.o(.text)` into
linker.ld between `sub_0800ce98.o` and the new `disasm_0x0800cf9c.o` slice, and
add `src/engine/sub_0800ced0.s: CC = $(OLD_AGBCC_BIN)` to the Makefile (sister
grid functions all build under old_agbcc).
