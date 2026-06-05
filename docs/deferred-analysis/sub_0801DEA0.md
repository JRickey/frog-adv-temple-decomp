# sub_0801DEA0 — deferred analysis (Round 19, Opus)

Two-row glyph text writer into one of four EWRAM tilemap scratch buffers
(`0x02000000 + screen * 0x800`). Each glyph occupies one tilemap column over
two rows: the top tile at `addr = rowBase*64 + colBase*2 + base`, the bottom
tile at `addr + 0x40`. Direct sibling of the already-matched `sub_0801C078`
(same `sub_0801CEC0` escape decoder, same `sCreditsTilemapEng` bracket table
at ROM 0x081bee64). Callee `sub_0801CEC0` is already peeled (no peel needed).

The C MODEL IS CORRECT: with the best-effort C below, every built instruction
from offset **0xe0 to the end of the function matches the baserom byte-for-byte**.
All remaining diff is concentrated in offsets 0x0a–0xe0 (prologue arg
extraction, the `screen` switch, and the FIRST digit-store) — i.e. it is a pure
register-allocation / jump-pass coloring problem, not a wrong-shape problem.

## Drift

Best byte_diff reached: **284** (size 452 vs target 472), diff_count 140, with a
single `register u16 *base asm("r8")` pin (the best-effort C below).
Other configurations explored (all WORSE on raw byte_diff but each fixes a
different sub-problem, proving each is individually reachable):

- base=r8 + i=sl + palBits=r5 pins, for-loop: 338 — gets `tileBase`→r9 and the
  prologue arg-extraction shape EXACTLY (`ldr r0,[sp#52]; lsls#16; lsrs#16;
  mov r9,r0` and `lsls r5,#28; lsrs r5,#16`), but `palLow` lands in r4, not on
  the stack (sp#16), so `sub sp,#16` vs baserom `sub sp,#20` and every stack-arg
  offset shifts by 4 (cascade).
- Same pins + a `do { … } while` loop with `i = (u8)(i+1)` tail and `i` typed
  `s32`: 328–336 — this FORCES `palLow` onto the stack (`str r0,[sp#16]`) and
  makes the loop-guard `cmp sl, count` and the `str[i]` indexing (`add r3, sl`,
  no re-mask) match the baserom — BUT agbcc then splits the sign-extend: it
  stores `palBits<<16` and emits the `asrs #16` on the READ side
  (`ldr r0,[sp#16]; asrs r4,r0,#16`) every iteration, whereas the baserom does
  `lsls#16; asrs#16` ONCE before the store (back-edge re-enters AFTER the store,
  so palLow is computed once and read raw).

### The THREE residual agbcc divergences (each a known permuter-class coloring/jump minimum)

1. **`screen` switch cross-jump merge.** Baserom merges case0+case3's
   `mov r8, r0` (case0 materializes 0x02000000 via `movs r0,#0x80; lsls#18`,
   case3 loads 0x02001800 from a FAR shared pool into r0 → shared `mov r8,r0`),
   while case1 (`mov r8,r1`) and case2 (`mov r8,r2`) stay distinct. agbcc's
   final `jump_optimize(JUMP_CROSS_JUMP)` pass instead merges case1+case3 (both
   `mov r8,r1`). The merge set is decided by which register each pool constant
   lands in, which I could not steer from C. `-fno-thread-jumps`,
   `-fno-cse-skip-blocks`, `-fforce-addr`, `-fno-defer-pop` had NO effect (the
   cross-jump is unconditional at -O2; gcc 2.x has no `-fno-crossjumping`).
   Reordering the `case` labels (1,2,3,0) changed the merge set but not to the
   baserom's. NEXT: try instrumenting `jump.c:do_cross_jump` to log which blocks
   merge, or find the C shape in the corpus that yields case0+caseN sharing.

2. **`palLow = (s16)palBits` placement: stack vs register, and where the asrs lands.**
   palLow is a loop-invariant; the baserom keeps it on the stack at sp#16
   (computed once at loop entry, read raw each iteration), agbcc prefers to keep
   it in a callee-saved reg (r4) and recompute. Forcing the do/while gets it onto
   the stack but moves the `asrs` to the read side (see above). This is the exact
   "spilled invariant" coloring the permuter is designed to escape.

3. **Cascading register ripple.** The function has 7 simultaneously-live values
   (base, tileBase, i, palBits, colBase, rowBase, palLow) for 7 callee-saved regs
   (r4–r7,r8,r9,sl) — right at the boundary, so fixing one assignment displaces
   another (e.g. computing palLow before the loop puts palLow in r9 and spills
   tileBase). agbcc's allocation ORDER (local-alloc.c `QTY_CMP_PRI` =
   `log2(refs)*refs*size/lifespan`) differs from the original compiler's by one
   tie-break.

### Levers tried (none reached 0)
- Compiler swap `CC = $(AGBCC_BIN)` (newer agbcc): no change to the high-reg
  allocation (still 301/299 class).
- Per-TU CFLAGS: `-fno-gcse`, `-fno-cse-follow-jumps`, `-fno-force-mem`,
  `-fno-schedule-insns`, `-fno-strength-reduce`, `-fno-thread-jumps`,
  `-fno-cse-skip-blocks`, `-fforce-addr [-fno-expensive-optimizations]`,
  `-O1`, `-ffixed-r3`, `-ffixed-r4` — all left byte_diff in 299–404, none fixed
  the switch merge or the palLow placement.
- Pins: `base=r8` (helps, −15), `i=sl`, `palBits=r5`, `tile=r9` copy (the copy
  ADDS a `mov r9,r4` the baserom lacks — avoid), volatile palLow (worse), a
  `&palLow` pointer alias (worse, 421), an `asm("":"+r"(palLow))` barrier (no
  effect on the split).
- **Permuter UNAVAILABLE in this worktree**: `vendor/decomp-permuter` symlink in
  main is itself broken/recursive ("Too many levels of symbolic links") and has
  no `.venv`. This function is the textbook permuter case (statement-order /
  scope mutation to flip a coloring/spill decision) — re-run with a working
  permuter from the 284 base, or from the 336 do/while base which already has
  palLow on the stack and only needs the asrs-placement + switch-merge flips.

## Best-effort C
(byte_diff 284, all diff confined to offsets 0x0a–0xe0; everything from 0xe0 on
matches the baserom exactly. `col`/`row` are deliberately uninitialised locals —
they are only read in the `[..]` bracket address, mirroring `sub_0801C078`.)

```c
#include "macros.h"
#include "types.h"

enum TextGlyph {
    GLYPH_ZERO_INDEX = 9,
    GLYPH_LETTER_BASE = 20,
    GLYPH_STAR_TOP = 0x24,
    GLYPH_STAR_BOTTOM = 0x24 - 0x1B,
    GLYPH_TILDE = 0x192,
};

extern s32 sub_0801CEC0(const char *str, u8 len);

extern const u16 sCreditsTilemapEng[];

void sub_0801DEA0(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen)
{
    register u16 *base asm("r8");
    u8 i;
    s32 palBits;
    s32 col;
    s32 row;
    int c;
    s32 t;
    s32 glyph;
    s32 palLow;
    u16 *dst;
    s32 n;
    s32 letterIndex;

    palBits = (s32)((u32)(palBank << 28) >> 16);

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

            glyph = t * 2 + tileBase;
            dst = (u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base));
            *dst = palBits + glyph;
            *(u16 *)((u8 *)dst + 0x40) = palLow + glyph + 1;
        } else if ((letterIndex = c - 'A'), (u8)letterIndex <= 25) {
            glyph = letterIndex * 2 + GLYPH_LETTER_BASE + tileBase;
            dst = (u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base));
            *dst = palBits + glyph;
            *(u16 *)((u8 *)dst + 0x40) = palLow + glyph + 1;
        } else if ((letterIndex = c - 'a'), (u8)letterIndex <= 25) {
            glyph = letterIndex * 2 + GLYPH_LETTER_BASE + tileBase;
            dst = (u16 *)((rowBase << 6) + (u32)(colBase * 2 + (u32)(u8 *)base));
            *dst = palBits + glyph;
            *(u16 *)((u8 *)dst + 0x40) = palLow + glyph + 1;
        } else if (c == '[' && str[i + 4] == ']') {
            n = sub_0801CEC0((const char *)(str + i + 1), 3) - 0xC0;
            if ((u32)n <= 63) {
                dst = (u16 *)(((row * 2 + rowBase) << 6) + (u32)(col * 2 + (u32)(colBase * 2 + (u32)(u8 *)base)));
                *dst = sCreditsTilemapEng[(n * 3 + 1) * 2];
                *(u16 *)((u8 *)dst + 0x40) = sCreditsTilemapEng[(n * 3 + 2) * 2];
            }
            i += 4;
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

## Notes for the next attempt
- Resume from the **do/while + base=r8/i=sl/palBits=r5** variant (byte_diff ~328-336):
  it already has palLow on the stack (sp#16), the `cmp sl, count` loop guard, the
  raw `str[i]` indexing (`add r3, sl` with `i` typed `s32` + `i = (u8)(i+1)` tail),
  and `tileBase` in r9. The only two residuals there are (a) the `asrs` placement
  (store-side vs read-side) and (b) the switch cross-merge. A working permuter
  almost certainly flips both.
- The switch may also yield to instrumenting `tools/agbcc-src/gcc_arm/jump.c`
  `do_cross_jump` / `find_cross_jump` in a PRIVATE debug build (never the shared
  symlink) to see which blocks it picks, then reshaping the case bodies to make
  case0 and case3 the merge pair.
