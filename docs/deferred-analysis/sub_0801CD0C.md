# sub_0801CD0C — deferred analysis

UI window-frame draw + inner-string render. Range [0x0801cd0c, 0x0801cec0),
436 bytes, asm/disasm_0x0801cd0c.s -> src/engine/sub_0801cd0c.c.

## Semantics (fully understood — geometry is correct)

Draws a 3x3-tile bordered window into BG screenblock 31 (VRAM 0x0600F800)
using the 9-tile stamp `sUiWindowBorderTiles[9]` (data already extracted in
src/data/ui_text_tables.c; column-major order TL,L,BL,T,C,B,TR,R,BR), then
scans the inner string up to '|' and renders it via sub_0801C078.

Signature (verified against the prologue + the sub_0801C078 tail call):
`void sub_0801CD0C(u8 col, u8 row, const u8 *str, u8 innerRows, u8 width,
                   u16 palColor, u16 frames)`
- `*(u16*)0x05000000 = palColor;`  (BG palette entry 0)
- `rows2 = ((u32)innerRows << 25) >> 24;`  (= 2*(innerRows & 0x7F))
- cell offset within the screenblock = `row*64 + col*2`
- VRAM pool literals: BG31=0x0600F800, BG31_ROW2=0x0600F840 (+1 row),
  BG31_COL2=0x0600F802 (+1 col), BG31_ROW2_COL2=0x0600F842.
- Tail call: `sub_0801C078(str, len, col+1, row+1, 0xa0, 14, 3)`.
- Callee sub_080008DC = VBlankWait (busy-wait on bit0 of *(u16*)0x03006148).

The per-column VBlank loop is INSIDE the column loop, REUSES the interior
fill counter `i` (left at `rows2`), and its back-edge is `bhi` (continue
while `i > frames`) — i.e. `for (; i > frames; i++) VBlankWait();`. This
exact shape (no reset, `bhi`, frames reloaded from stack) was confirmed
from the baserom asm and is reproduced by the best-effort C below.

## Drift

Best: byte_diff 334, diff_count 114 (Thumb). Build is structurally correct
end-to-end; the geometry, loop nest, string scan and tail call all match.
The residual is a sharp REGISTER-COLORING local minimum, ~5 coupled
allocator decisions that cascade into the prologue frame size:

1. `frames` (arg6) vs `col*2` competition for the last callee-saved high
   reg `sl`. Target: sl = col*2 (recomputed via `lsls` from r9 at each use),
   `frames` SPILLED to [sp,#20]. Built: sl = frames (kept resident because
   the innermost VBlank loop reads it), col*2 spilled. This single swap is
   what makes the built frame `sub sp,#48` vs target `sub sp,#44` and shifts
   ~10 [sp,#N] slot operands.
2. `row` (arg1): target keeps it in callee-saved r8; agbcc puts it in
   caller-saved `ip`. (col correctly lands in r9 in both.)
3. `rows2`: target r7 (low callee-saved); agbcc r8.
4. SRC[1] (`sUiWindowBorderTiles[1]`) loop-invariant hoist: target loads it
   once into r3 before the left-edge loop (`adds r1,r3,#0; ldr; ldr; ldrh
   r3,[r0,#2]`); built copies the SRC base into r0 then loads into r1 — a
   2-byte shift that ripples the left-edge loop body register set.
5. BL-corner `row*64 + col*2` operand evaluation order: target row-first
   (`mov r1,r8; lsls r2,r1,#6; mov r6,r9; lsls r3,r6,#1; adds r5,r2,r3`);
   built col-first with swapped `adds` operands.

## Levers tried (none reached < 114)

- `-fno-strength-reduce` (REQUIRED: gets the recomputed `i*64` per iter +
  u8-masked counters + the bcs/bcc unsigned loop bounds; baseline without it
  was diff 273). KEEP this flag for any resume.
- compiler swap OLD_AGBCC <-> AGBCC_BIN: identical output (114) either way.
- flag sweep: -fno-gcse, -fno-schedule-insns[2], -f[no-]caller-saves,
  -fno-cse-follow-jumps, -fno-expensive-optimizations, -fforce-mem,
  -fforce-addr — all 114 (no change). -fno-rerun-cse-after-loop = 227 (worse).
  -ffixed-r10 = 116/419 worse (target USES sl, so don't fix it).
- register pins: `register u32 rows2 asm("r7")` pins rows2 to r7 but then
  agbcc moves col r9->r8 and row->ip (cascade, byte_diff 370). Pinning
  col=r9/row=r8/rows2=r7 via param-copy locals added movs (296). Pinning
  row=r8 via a copied local broke col's r9. Pins THRASH here — the right
  tool is the permuter, which is UNAVAILABLE in the worktree (vendor/
  decomp-permuter is a broken self-referential symlink; .venv missing).
- structural: caching `colX2`/`rowX64` as locals (261/164 worse — target
  recomputes from col/row, does not cache); caching the tiles base pointer
  (140 worse — target reloads SRC from pool per section); flipping all
  `(row*64+col*2)` to col-first (118, byte_diff 291 — mixed).

## Resume hint

Start from the Best-effort C below WITH `-fno-strength-reduce`. The match is
~5 coupled coloring decisions away; run vendor/decomp-permuter (once its
.venv is restored on a non-worktree checkout) from this near-match base, or
hand to codex. The leverage decision to crack first is #1 (make `col*2`
claim `sl` and force `frames` to spill to [sp,#20]); that alone collapses the
frame-size cascade and should drop diff_count below ~40.

## Best-effort C

```c
#include "macros.h"
#include "types.h"

#define BG31 0x0600F800
#define BG31_ROW2 0x0600F840
#define BG31_COL2 0x0600F802
#define BG31_ROW2_COL2 0x0600F842

#define WINDOW_TL 0
#define WINDOW_L  1
#define WINDOW_BL 2
#define WINDOW_T  3
#define WINDOW_C  4
#define WINDOW_B  5
#define WINDOW_TR 6
#define WINDOW_R  7
#define WINDOW_BR 8

extern const u16 sUiWindowBorderTiles[9];

extern void sub_080008DC(void);
extern void sub_0801C078(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen);

void sub_0801CD0C(u8 col, u8 row, const u8 *str, u8 innerRows, u8 width, u16 palColor, u16 frames)
{
    u32 rows2;
    s32 cellOff;
    u8 i;
    u8 j;
    u8 len;

    *(u16 *)0x05000000 = palColor;

    rows2 = ((u32)innerRows << 25) >> 24;

    cellOff = row * 64 + col * 2;
    *(u16 *)(BG31 + cellOff) = sUiWindowBorderTiles[WINDOW_TL];

    for (i = 0; i < rows2; i++) {
        *(u16 *)(BG31_ROW2 + i * 64 + cellOff) = sUiWindowBorderTiles[WINDOW_L];
    }

    *(u16 *)(BG31_ROW2 + rows2 * 64 + (row * 64 + col * 2)) = sUiWindowBorderTiles[WINDOW_BL];

    for (j = 1; j <= width; j++) {
        *(u16 *)(BG31 + j * 2 + (row * 64 + col * 2)) = sUiWindowBorderTiles[WINDOW_T];

        for (i = 0; i < rows2; i++) {
            *(u16 *)(BG31_ROW2 + i * 64 + (row * 64 + col * 2) + j * 2) = sUiWindowBorderTiles[WINDOW_C];
        }

        *(u16 *)(BG31_ROW2 + (rows2 * 64 + (row * 64 + col * 2)) + j * 2) = sUiWindowBorderTiles[WINDOW_B];

        for (; i > frames; i++) {
            sub_080008DC();
        }
    }

    *(u16 *)(BG31_COL2 + width * 2 + (row * 64 + col * 2)) = sUiWindowBorderTiles[WINDOW_TR];

    for (i = 0; i < rows2; i++) {
        *(u16 *)(BG31_ROW2_COL2 + i * 64 + (row * 64 + col * 2) + width * 2) = sUiWindowBorderTiles[WINDOW_R];
    }

    *(u16 *)(BG31_ROW2_COL2 + rows2 * 64 + (row * 64 + col * 2) + width * 2) = sUiWindowBorderTiles[WINDOW_BR];

    len = 0;
    while (str[len] != '|') {
        len++;
    }

    sub_0801C078(str, len, (u8)(col + 1), (u8)(row + 1), 0xa0, 14, 3);
}
```

Makefile flag (required when resuming): 
`src/engine/sub_0801cd0c.s: CFLAGS += -fno-strength-reduce`
