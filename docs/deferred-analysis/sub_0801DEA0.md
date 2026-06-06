# sub_0801DEA0 — deferred analysis (Round 24, Opus escalation)

Two-row glyph text writer into one of four EWRAM tilemap scratch buffers
(`0x02000000 + screen * 0x800`). Each glyph occupies one tilemap column over two
rows: top tile at `(rowBase<<6) + colBase*2 + base`, bottom tile at `top + 0x40`.
Direct sibling of the already-matched `sub_0801C078` (same `sub_0801CEC0` escape
decoder, same `sCreditsTilemapEng` bracket table at ROM 0x081bee64). Callee
`sub_0801CEC0` is already peeled.

## STATUS: re-derived from scratch this round. Best byte_diff **256** (size 472
exact, diff_count 123) — IMPROVED from the prior Round-19 plateau of 284. TWO of
the prior note's THREE named residuals are now SOLVED in pure C with NO register
pins. Only the third (a global/local register-allocation interaction) remains.

The "## Best-effort C" below is a *better base* than the prior note's — resume
from it, not from the r8-pinned 284 version.

## What was SOLVED this round (do NOT re-derive these)

1. **palLow on the stack (prior residual #2).** The bottom store value is
   `palLow + glyph + 1` where `palLow = (s16)palBits` is a loop-invariant the
   baserom computes ONCE in the loop preheader and reads from `[sp,#16]` each
   iteration. The ROOT CAUSE the prior attempt missed: pinning `palBits` to r5
   with `register s32 palBits asm("r5")` makes `(s16)palBits` read a HARD
   register, which gcc-2.x LICM (`loop.c` `move_movables`) refuses to hoist.
   Instrumenting `loop.c` (private debug `old_agbcc`, fprintf at the
   `threshold*savings*lifetime >= insn_count` decision) showed the `(s16)palBits`
   set was NOT EVEN in the movables list because its operand was a hard reg.
   **FIX: do NOT pin palBits.** Leave it a plain `s32 palBits;`. It then
   colors to r5 NATURALLY (the prologue `lsls r5,#28; lsrs r5,#16` matches
   byte-for-byte), and `(s16)palBits` becomes a hoistable pseudo invariant →
   LICM moves it to the preheader → spills to `[sp,#16]` (all 6 callee-saved
   regs r5–sl are taken). `sub sp,#20`, no `mov ip`, palLow read from stack.
   NO PINS AT ALL is the winning configuration — every pin the prior attempt
   added was compensating for the wrong-compiler / hard-reg-LICM-block.

2. **Switch case0+case3 `mov r8,r0` cross-jump merge (prior residual #1).**
   With the palBits pin removed, the natural allocation makes case0
   (`movs r0,#0x80; lsls#18`) and case3 (`ldr r0,[far pool]`) both land their
   value in r0 and SHARE the `mov r8,r0` tail (case0 `b 0x6a`, case3 falls
   through to 0x6a) — exactly the baserom. case1→r1, case2→r2 stay distinct.
   This required NO `-fno-thread-jumps`/case-reorder gymnastics; it falls out
   of the unpinned coloring. (Writing the switch as the explicit 4-case
   `switch(screen)` is correct; do NOT use `base = 0x02000000 + screen*0x800`
   — agbcc compiles THAT to a runtime multiply, not the cmp-tree, ~half the
   time and is unstable.)

   Also solved: the `i < count` loop guard is `bcc` (unsigned) iff `i` is
   declared `u32` (not s32/u8). The digit/letter A+a branches MERGE into one
   shared body automatically (cross-jump) when their store bodies are textually
   identical, matching baserom 0x1df78 — BUT only if the bottom letter store
   adds tileBase SEPARATELY (see below), which also fixes the tileBase ref count.

3. **tileBase in r9, not spilled.** The letter case in the baserom references
   tileBase (r9) TWICE — once for the top (`add r0,r9`) and once for the bottom
   (`add r1,r9`) — it does NOT reuse the top's `glyph` for the bottom. That gives
   tileBase 3 refs vs palLow's 2, so tileBase out-prioritizes palLow for r9
   (`global.c allocno_compare`, prio = log2(refs)*refs/live_length). Writing the
   letter stores as two independent `t + tileBase + K` expressions (NOT
   `glyph`/`glyph+1` reuse) is load-bearing for tileBase→r9.

## Drift — the ONE remaining residual (prior residual #3, "cascading ripple")

All 123 remaining diff instructions are ONE register-coloring divergence in the
digit + letter case bodies, plus its ripple:

- baserom: char `c`→r2, digit-index→**r1**, dst→**r2** (reused after c dies),
  glyph→r0.
- agbcc (mine): `c`→r2, digit-index→**r4** (a callee-saved reg!), dst→**r3**,
  glyph→r1.

ROOT CAUSE (confirmed by instrumenting `local-alloc.c` `find_free_reg`): `c` is a
global pseudo (live across the mutually-exclusive digit/letter/… branches), so
global-alloc reserves **r2** for it across the WHOLE loop body. The baserom's
original compiler reuses r2 for the per-branch `dst` temp *after c's local death*
within the digit branch; agbcc keeps r2 reserved, so the dst rowBase<<6 temp
takes r1, which pushes the digit index out to r4 (r1/r2/r3 all live during the
index's lifetime → `find_free_reg` returns r4). Every downstream digit/letter
instruction then differs only in register NUMBER (r4↔r1, r3↔r2), which is why
byte_diff is high (256) but diff_count is structural-zero — the shape is correct.

This is the textbook **decomp-permuter** case (reorder statements/scope to flip
which scratch a per-block temp gets, freeing r2's local reuse). The matched
sibling sub_0801C078 sidesteps it because it keeps `c` in a CALLEE-SAVED reg (r5)
— but THIS function's baserom keeps c in r2, so that escape isn't available here.

### Levers TRIED this round (none flipped the c/index/dst coloring)
- NO pins (256, best), base=r8 only (270), +i=sl (305), +palBits=r5 (307, but
  that REINTRODUCES the palLow-in-ip bug — do not pin palBits), all-6-pins (402).
- digit store order: glyph-first+mutate-dst (256/257) vs dst-first+glyph-reuse
  (259); dst-expr operand reorder `(colBase*2+base)+(rowBase<<6)` (−1 to 256).
- i type: u32 (fixes bcc), s32 (blt, wrong), u8 (re-masks). u32 is correct.
- separate digit-index var, block-scoped locals, u8 c, inline `(s16)palBits`,
  `s16 palLow`, volatile palLow, `-fmove-all-movables` (hoists ALL invariants,
  512B, wrong), `-ffixed-r3/r4` (447), compiler swap to newer agbcc (298,
  same coloring), and the full `-fno-{gcse,cse-*,thread-jumps,schedule-insns,
  expensive-opt,force-mem,defer-pop,strength-reduce}` set — all left the c/r2
  coloring unchanged.
- **decomp-permuter UNAVAILABLE this round**: `vendor/decomp-permuter` is a
  self-referential/recursive symlink with no `.venv` (main has no venv either).
  This function is the canonical permuter target; re-run with a working permuter
  from the Best-effort C below (it is byte_diff 256, all diff confined to the
  digit/letter scratch coloring), or instrument `global.c`/`local-alloc.c` to
  force r2's local reuse.

## Best-effort C (byte_diff 256, NO pins — resume from THIS, not the 284 version)

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
    u32 i;
    s32 palBits;
    s32 col;
    s32 row;
    int c;
    int t;
    s32 glyph;
    s32 palLow;
    u16 *dst;
    s32 n;
    int letterIndex;

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
            glyph = t * 2 + (u32)tileBase;
            dst = (u16 *)((u32)(colBase * 2 + (u32)(u8 *)base) + (rowBase << 6));
            *dst = palBits + glyph;
            dst = (u16 *)((u8 *)dst + 0x40);
            *dst = palLow + glyph + 1;
        } else if ((letterIndex = c - 'A'), (u8)letterIndex <= 25) {
            t = (u16)letterIndex * 2;
            dst = (u16 *)((u32)(colBase * 2 + (u32)(u8 *)base) + (rowBase << 6));
            *dst = palBits + (t + GLYPH_LETTER_OFFSET + (u32)tileBase);
            *(u16 *)((u8 *)dst + 0x40) = palLow + (t + (u32)tileBase + 21);
        } else if ((letterIndex = c - 'a'), (u8)letterIndex <= 25) {
            t = (u16)letterIndex * 2;
            dst = (u16 *)((u32)(colBase * 2 + (u32)(u8 *)base) + (rowBase << 6));
            *dst = palBits + (t + GLYPH_LETTER_OFFSET + (u32)tileBase);
            *(u16 *)((u8 *)dst + 0x40) = palLow + (t + (u32)tileBase + 21);
        } else if (c == '[' && str[i + 4] == ']') {
            n = sub_0801CEC0((const char *)(str + i + 1), 3) - 0xC0;
            if ((u32)n <= 63) {
                dst = (u16 *)(((row * 2 + rowBase) << 6) +
                              (u32)(col * 2 + (u32)(colBase * 2 + (u32)(u8 *)base)));
                *dst = *(u16 *)(sCreditsTilemapEng + ((n * 3 + 1) << 1));
                *(u16 *)((u8 *)dst + 0x40) = *(u16 *)(sCreditsTilemapEng + ((n * 3 + 2) << 1));
            }
            i += 4;
        } else if (c == ' ') {
            dst = (u16 *)((u32)(colBase * 2 + (u32)(u8 *)base) + (rowBase << 6));
            *dst = 0;
            *(u16 *)((u8 *)dst + 0x40) = 0;
        } else if (c == '*') {
            dst = (u16 *)((u32)(colBase * 2 + (u32)(u8 *)base) + (rowBase << 6));
            *dst = palBits + GLYPH_STAR_TOP;
            *(u16 *)((u8 *)dst + 0x40) = palBits + GLYPH_STAR_BOTTOM;
        } else if (c == '~') {
            dst = (u16 *)((u32)(colBase * 2 + (u32)(u8 *)base) + (rowBase << 6));
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

`col`/`row` are deliberately-uninitialised locals (only read in the bracket-case
address, mirroring sub_0801C078). The bracket case is the only one using them.

## Next attempt
- Resume from the Best-effort C (256, no pins). DO NOT re-pin palBits — that
  re-breaks LICM/palLow. The only open problem is the c/r2 local-reuse coloring.
- With a working permuter: `make_permuter_target.py` then a bounded run from the
  256 base; the mutation it needs is statement-reorder/scope within the digit &
  letter bodies to free r2 for the dst temp.
- Without a permuter: instrument `local-alloc.c`/`global.c` (private debug
  old_agbcc — recipe worked this round) to see why r2 isn't locally reused after
  c's death in the digit branch, then find the C shape that lets it.
