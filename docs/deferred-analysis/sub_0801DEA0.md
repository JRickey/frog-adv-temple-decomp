# sub_0801DEA0 — deferred analysis (Round 31, Opus escalation)

> **Update (2026-06-06):** the standalone asm slice `asm/disasm_0x0801dea0.s` was
> absorbed into this function's TU `src/engine/sub_0801dea0.c` as an `#else` NAKED `.incbin`
> (matching bytes unchanged) and the slice file removed. The readable C stays under
> `#ifdef NON_MATCHING` in that TU — resume the match there.

Two-row glyph text writer into one of four EWRAM tilemap scratch buffers
(`0x02000000 + screen * 0x800`). Each glyph occupies one tilemap column over two
rows: top tile at `(rowBase<<6) + colBase*2 + base`, bottom tile at `top + 0x40`.
Sibling of the matched single-row writers `sub_0801C078` / `sub_0801DBB4` (same
`sub_0801CEC0` escape decoder + `sCreditsTilemapEng` bracket table at ROM
0x081bee64). Callee `sub_0801CEC0` is peeled.

## STATUS: re-derived from scratch this round. Best byte_diff **172** (size 476,
1 extra instruction, diff confined to per-branch register coloring). This is an
84-byte IMPROVEMENT over the Round-24 plateau of 256 and a *qualitatively better
base* — the digit AND letter branches now match the baserom BYTE-FOR-BYTE. The
remaining diff is one allocator-version divergence (local-reuse of dead globals)
that needs decomp-permuter — UNAVAILABLE this run (the `vendor/decomp-permuter`
submodule is an empty mountpoint on main, no `.venv`; cannot init from a worktree
without racing siblings).

Resume from the "## Best-effort C" below (byte_diff 172). Do NOT restart from the
256 version.

## What is now SOLVED byte-for-byte (do NOT re-derive)

1. **`i` is `u8`, not u32.** The baserom masks `i` on every increment
   (`mov r0,sl; adds r0,#1; lsls #24; lsrs #24; mov sl,r0`) AND on the bracket
   `i += 4`. The prior note's "u32 is correct" was WRONG — u32 drops the mask
   (size 468, 4 short). Declare `u8 i;` and write the bracket advance as
   `i = (u8)(i + 4);`. Gives the masked increments + the unsigned `bcc`/`bcs`
   loop guard. Size becomes 472-correct.

2. **digit dst → r2 via a SPLIT dst assignment + an `asm("r2")` pin.** The dst
   pointer must be built `rowBase<<6` FIRST into the pinned reg, THEN add
   `colBase*2+base`, as two statements:
   ```c
   register u16 *dr2 asm("r2");
   dr2 = (u16 *)(rowBase << 6);
   dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
   ```
   The split is load-bearing: the one-expression form `(rowBase<<6)+(col..+base)`
   evaluates the SECOND operand into r2 first (`adds r2,r0,r2`); the split forces
   the baserom's `adds r2,r2,r0`. WITH the split + pin, the digit index `t` also
   colors to **r1** (baserom), not r4. The digit branch then matches exactly.
   Bottom store value is `palLow + (glyph + 1)` (parenthesize so `+1` is on
   glyph, matching `adds r0,#1` before the palLow add).

3. **letter branch matches** with the same split + `t` MUTATED in place for the
   bottom (mirrors the baserom's `add r1,r9; adds r1,#21` in-place on the t reg):
   ```c
   u = t + GLYPH_LETTER_OFFSET; u += (u32)tileBase; *dr2 = palBits + u;   /* top */
   t += (u32)tileBase; t += 21; *(u16 *)((u8*)dr2+0x40) = palLow + t;     /* bottom */
   ```
   Staging top into `u` forces `adds r0,r1,#0; adds r0,#20; add r0,r9` (t copied
   to r0, NOT `mov r0,r9`); mutating `t` for the bottom keeps t in r1 and does the
   in-place `add r1,r9`. The `(u32)tileBase` casts are load-bearing (u16 tileBase
   promotes wrong: byte_diff explodes to 339 without them).

4. **switch + count-guard are CORRECT only WITHOUT the pin.** See drift below.

## Drift — the ONE remaining residual: agbcc local-reuses dead global regs

ROOT CAUSE (confirmed by reading `tools/agbcc-src/gcc_arm/config/arm/arm.h`
`REG_ALLOC_ORDER = {3,2,1,0,12,14,4,5,...}` and `local-alloc.c find_free_reg`):
the baserom's original compiler **globally reserves** r2 for `c` (the char) and
r3 for `p`=`str+i` across the WHOLE loop body and does NOT locally reuse them in a
block where they are dead — EXCEPT it reuses r2 in the digit/letter branches.
agbcc's `local-alloc` AGGRESSIVELY reuses any dead register inside a block (r3
first per alloc order), so:

- **digit/letter dst** naturally wants r3 (p's dead reg) → wrong; the `asm("r2")`
  pin fixes it (→ 172).
- BUT the `asm("r2")` pin is a FUNCTION-GLOBAL reservation (block-scoping the
  `register` decl does NOT narrow it — verified). So it pushes the switch case-2
  literal and BOTH `i<count` guard loads from r2 (baserom) to r3 (~6 bytes).
- **space/star/tilde dst** = r3 in BOTH pin and no-pin builds; baserom = r0/r0/r1
  (because baserom holds r2=c AND r3=p reserved, forcing dst to r0/r1). agbcc
  reuses the dead r3. ~the bulk of the residual.
- **bracket** dst/table are an r2↔r3 swap, same cause.

The remaining 172 is ALL register-NUMBER renumbering (r0↔r3, r1↔r2, r2↔r3) with
identical instruction shape (233 vs 233 lines, 1 extra insn). diff_count is
structural-near-zero.

### The decisive un-tried lever: extend `p`=str+i liveness across the branches
If `p` (str+i) were genuinely LIVE across the digit/letter/space/star/tilde
bodies, r3 would be busy everywhere and the WHOLE function would color like the
baserom with NO pins (dst→r2 in digit/letter where c dies; dst→r0/r1 in
space/star/tilde where both c,p reserved; t→r1). The baserom achieves this via
global reservation; agbcc kills p locally because p's only uses are the loop-top
read and the bracket case (dead on every other path). NO pin or `-fXXX` flag
extends liveness (verified: pinning p to r3 is still locally reused; an
`asm("" ::"r"(p))` barrier forces reloads, +instructions, 361). This is the
exact statement-reorder/scope mutation decomp-permuter is built for.

### Levers TRIED this round (none closed the local-reuse gap)
- Best path: `u8 i` + split-dst + `asm("r2")` pin on digit/letter dst + staged
  letter top + mutated letter t  → **172**.
- no-pin (digit dst→r2 via split alone, but t→r3; switch/guard correct) → 229.
- block-scoped `asm("r2")` (still global reservation) → 172, no change.
- pin t to r1 (no-pin base) → 236. pin p to r3 + live pointer → 172/229 (no-op,
  p locally reused regardless). unify all branches to one `dst` (no pin) → 210.
- pin space/star/tilde dst to r0/r0/r1 → 311 (conflicts with the store-value
  scratch; spills).
- flags swept (all no-op on the coloring): `-fno-{gcse,cse-follow-jumps,
  thread-jumps,rerun-cse-after-loop,strength-reduce,schedule-insns,defer-pop,
  function-cse,peephole,caller-saves}`; `-ffixed-r3` → 420; `-fno-omit-frame-
  pointer` → 481.
- `(u32)tileBase` casts REQUIRED (dropping → 339). dst operand order REQUIRED
  (rowBase<<6 first via split). col/row update: original order `if (colBase<=30)
  colBase++; else if (rowBase>30) break; else {colBase=0;rowBase++;}` matches the
  baserom's `bls` (do NOT invert to colBase>30-first; that's +1).

## Best-effort C (byte_diff 172, ONE `asm("r2")` pin — resume from THIS)

```c
#include "macros.h"
#include "types.h"

enum TextGlyph {
    GLYPH_LETTER_OFFSET = 20,
    GLYPH_ZERO_INDEX = 9,
    GLYPH_STAR_TOP = 0x24,
    GLYPH_STAR_BOTTOM = 0x24 - 0x1B,
    GLYPH_TILDE = 0x192,
};

extern s32 sub_0801CEC0(const char *str, u8 len);

extern const u8 sCreditsTilemapEng[];

void sub_0801DEA0(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen)
{
    u16 *base;
    u8 i;
    s32 palBits;
    s32 col;
    s32 row;
    int c;
    int t;
    s32 glyph;
    s32 palLow;
    u16 *dst;
    register u16 *dr2 asm("r2"); /* digit/letter dst must reuse c's r2; pin reserves it */
    s32 n;
    int letterIndex;
    s32 u;

    palBits = (u32)(palBank << 28) >> 16;

    switch (screen) {
    case 0:
        base = (u16 *)0x02000000;
        break;
    case 1:
        base = (u16 *)0x02000800;
        break;
    case 2:
        base = (u16 *)0x02001000;
        break;
    case 3:
        base = (u16 *)0x02001800;
        break;
    }

    for (i = 0; i < count; i++) {
        palLow = (s16)palBits;
        c = str[i];

        if ((u8)(c - '0') <= 9) {
            if (c == '0') {
                t = GLYPH_ZERO_INDEX;
            } else {
                t = (u16)(c - '1');
            }
            dr2 = (u16 *)(rowBase << 6);
            dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
            glyph = t * 2 + (u32)tileBase;
            *dr2 = palBits + glyph;
            dr2 = (u16 *)((u8 *)dr2 + 0x40);
            *dr2 = palLow + (glyph + 1);
        } else if ((letterIndex = c - 'A'), (u8)letterIndex <= 25) {
            t = (u16)letterIndex * 2;
            dr2 = (u16 *)(rowBase << 6);
            dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
            u = t + GLYPH_LETTER_OFFSET;
            u += (u32)tileBase;
            *dr2 = palBits + u;
            t += (u32)tileBase;
            t += 21;
            *(u16 *)((u8 *)dr2 + 0x40) = palLow + t;
        } else if ((letterIndex = c - 'a'), (u8)letterIndex <= 25) {
            t = (u16)letterIndex * 2;
            dr2 = (u16 *)(rowBase << 6);
            dr2 = (u16 *)((u32)dr2 + (u32)(colBase * 2 + (u32)(u8 *)base));
            u = t + GLYPH_LETTER_OFFSET;
            u += (u32)tileBase;
            *dr2 = palBits + u;
            t += (u32)tileBase;
            t += 21;
            *(u16 *)((u8 *)dr2 + 0x40) = palLow + t;
        } else if (c == '[' && str[i + 4] == ']') {
            n = sub_0801CEC0((const char *)(str + i + 1), 3) - 0xC0;
            if ((u32)n <= 63) {
                dst = (u16 *)(((row * 2 + rowBase) << 6) +
                              (u32)(col * 2 + (u32)(colBase * 2 + (u32)(u8 *)base)));
                *dst = *(u16 *)(sCreditsTilemapEng + ((n * 3 + 1) << 1));
                *(u16 *)((u8 *)dst + 0x40) = *(u16 *)(sCreditsTilemapEng + ((n * 3 + 2) << 1));
            }
            i = (u8)(i + 4);
        } else if (c == ' ') {
            dst = (u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base));
            *dst = 0;
            *(u16 *)((u8 *)dst + 0x40) = 0;
        } else if (c == '*') {
            dst = (u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base));
            *dst = palBits + GLYPH_STAR_TOP;
            *(u16 *)((u8 *)dst + 0x40) = palBits + GLYPH_STAR_BOTTOM;
        } else if (c == '~') {
            dst = (u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base));
            *dst = palBits + GLYPH_TILDE;
        }

        if (colBase <= 30) {
            colBase = (u8)(colBase + 1);
        } else if (rowBase > 30) {
            break;
        } else {
            colBase = 0;
            rowBase = (u8)(rowBase + 1);
        }
    }
}
```

`col`/`row` are deliberately-uninitialised (only read in the bracket-case address,
mirroring the matched siblings).

## Next attempt
- Resume from the Best-effort C (172). The whole residual is the dead-global
  local-reuse coloring (space/star/tilde dst r3 vs r0/r1; switch case-2 + guards
  r3 vs r2). It is register-renumbering only.
- WITH a working permuter: `make_permuter_target.py`, then a bounded run from the
  172 base. The mutation needed is statement-reorder/scope so `p`=str+i stays live
  across the branch bodies (→ r3 busy everywhere → baserom coloring with NO pins).
  Try BOTH the pinned-172 base AND the no-pin-229 base as permuter seeds.
- WITHOUT a permuter: the only lever left is instrumenting `local-alloc.c`
  `block_alloc`/`wipe_dead_reg` to suppress dead-global local reuse for this TU —
  but there is no `-fXXX` for it, so it would require a private patched agbcc and
  is not byte-stable. Permuter is the right tool.
