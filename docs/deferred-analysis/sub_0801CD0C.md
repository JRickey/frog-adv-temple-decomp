# sub_0801CD0C — deferred analysis (round 22 update)

UI window-frame draw + inner-string render. Range [0x0801cd0c, 0x0801cec0),
436 bytes, asm/disasm_0x0801cd0c.s -> src/engine/sub_0801cd0c.c.

## Semantics (fully understood — geometry is correct)

Draws a 3x3-tile bordered window into BG screenblock 31 (VRAM 0x0600F800)
using the 9-tile stamp `sUiWindowBorderTiles[9]` (in src/data/ui_text_tables.c;
column-major TL,L,BL,T,C,B,TR,R,BR at 0x081bdf70), scans the inner string up
to '|', renders it via sub_0801C078.

Signature (verified against prologue + sub_0801C078 tail call):
`void sub_0801CD0C(u8 col, u8 row, const u8 *str, u8 innerRows, u8 width,
                   u16 palColor, u16 frames)`
- `*(u16*)0x05000000 = palColor;`  (BG palette entry 0)
- `rows2 = ((u32)innerRows << 25) >> 24;`  (= 2*(innerRows & 0x7F))
- cellOff = `row*64 + col*2`
- VRAM literals: BG31=0x0600F800, BG31_ROW2=0x0600F840, BG31_COL2=0x0600F802,
  BG31_ROW2_COL2=0x0600F842.
- Tail call: `sub_0801C078(str, len, col+1, row+1, 0xa0, 14, 3);`
- Callee sub_080008DC = VBlankWait. The per-column VBlank loop reuses the
  interior fill counter `i` (left at rows2), back-edge `bhi` (continue while
  `i > frames`): `for (; i > frames; i++) VBlankWait();`.

## Two distinct register-coloring LOCAL MINIMA (the whole problem)

The target needs ALL FIVE of these simultaneously:
  col->r9, row->r8, rows2->r7, col*2->sl, frames->SPILLED([sp,#20]).
No source shape tried gets all five at once. There are exactly two reachable
minima and they are MUTUALLY EXCLUSIVE under every lever tried:

### Minimum A — "pure cellOff" (prior round, byte_diff 333, frame 48)
C body uses a single `cellOff = row*64 + col*2` local EVERYWHERE.
  - col->r9 ✓, row->r8 ✓, rows2->r7 ✓   (ALL correct)
  - frames->sl ✗  (col*2 never exists as a separate value, so sl is free and
    frames grabs it; target wants col*2->sl and frames spilled)

### Minimum B — "split row*64+col*2" (THIS round, byte_diff 319, frame 52) <-- NEW BEST
C body uses `cellOff` local for TL+L only, and the raw inline
`(row * 64 + col * 2)` everywhere else (BL/T/B parenthesised; C-fill/TR/R/BR
unparenthesised).
  - frames->[sp,#20] SPILLED ✓ (exactly target's 0x2a `str r4,[sp,#20]`)
  - col*2->sl ✓ (exactly target's 0x86 `mov sl,r3`)
  - frame intent right (the sl/frames swap that blocked round 1 is SOLVED)
  - col->ip ✗, row->r9 ✗  (col*2 being a live value steals the priority that
    in minimum A let col/row claim r9/r8; they fall to ip/r9)

Region diff of minimum B (byte_diff 319, 173 differing instrs):
  prologue=6  TL=19  L=16  BL+setup=28  T=9  C=35  B=20  VBlank=28
  TR+R+BR=73  strscan+call=58

So round 1's blocker (sl=frames) is now FIXED in minimum B; the residual is a
DIFFERENT coloring decision: col/row no longer get the high callee-saved regs.

## The genuine remaining barrier: cellOff register-COALESCING

The target, at the width-loop preheader (0xa2-0xa4), does
  `mov r9, r5`  (r9 = cellOff, REUSING col's now-dead register)
  `mov r8, ip`  (r8 = rows2*64+cellOff, REUSING row's now-dead register)
i.e. it COALESCES the cellOff pseudo into the freed col/row hard registers and
keeps cellOff resident in r9/r8 across the whole width loop. agbcc instead
SPILLS cellOff and rows2*64+cellOff to fresh stack slots (the 2 extra slots =>
frame 52 vs 44). col/row ARE dead at the preheader in minimum B (verified:
TR/R/BR read precomputed slot+sl, no `lsl #6`/`lsl #1` recompute), yet the
allocator refuses to coalesce cellOff into r9. This is a reload/coalesce
decision in global.c/reload1.c, not something the C source exposes.

Target's exact structure (for the next attempt to match):
  cellOff (r5) is computed ONCE at the BL corner (0x72 `adds r5,r2,r3`), kept
  live in r5 through the entire setup (0x84-0x9a stores), then moved to r9 at
  0xa2. agbcc recomputes cellOff at the preheader and immediately spills it.

## Levers tried this round (none beat 319)

- `-fno-strength-reduce`: REQUIRED (keeps recomputed i*64, u8-masked counters,
  bcs/bcc unsigned bounds). KEEP for any resume.
- Flag sweep on the minimum-B base, ALL identical 319 (no perturbation):
  -fno-gcse, -fno-schedule-insns, -fno-schedule-insns2, -fno-cse-follow-jumps,
  -f[no-]caller-saves, -fno-expensive-optimizations, -fno-force-mem,
  -fforce-addr, -fno-rerun-cse-after-loop, -fno-thread-jumps,
  -fomit-frame-pointer, -ffixed-r4/r5/r6/r7, -ffixed-ip.
- compiler swap OLD_AGBCC <-> AGBCC_BIN: no change (default OLD_AGBCC).
- Pins all THRASH (cascade worse): col=r9/row=r8 (404); rows2=r7 (370);
  cellOff=r9 or =sl (348); colX2=sl explicit (377/378). Every pin fixes one
  reg and the rest cascade.
- Structural variants and their byte_diff (minimum B = 319 is the floor):
  cellOff-everywhere 392; cellOff for BL/T/B too 416; exact target
  combined/split mix (cellOff for T-edge, split C-fill) 416; rowX64 local for
  splits 384; rowX64+colX2 locals 382; two cellOff vars (cellOff + cellOff2)
  398; cellOff reassigned at BL 381; BL reuses cellOff local 413;
  no-cellOff all-inline (frame 44 but col->ip) 354.

## Corpus

`corpus_asm_search.py search --asm 'mov +(r8|r9|sl), *ip' --require-c` confirms
the dead-param-register-REUSE idiom (`mov sl,ip` etc.) IS matched in pure C in
metroidret/mzm, fireemblem8u, katam, mother3 (9-14 commits each). So the
coalescing IS reproducible from pure C — it is a coloring search, not an
impossibility. This is ATTEMPT_MATCH, NOT a NAKED candidate.

## Resume hint

Start from minimum B (the "## Best-effort C" below) WITH
`-fno-strength-reduce`. byte_diff 319; round 1's sl=frames blocker is solved.
The ONE decision left to crack: force agbcc to COALESCE cellOff into the freed
col(r9)/row(r8) registers at the width-loop preheader instead of spilling to
2 fresh slots (which inflates frame 44->52 and shifts every [sp,#N]).
- The permuter is the right tool and was UNAVAILABLE in this worktree
  (vendor/decomp-permuter symlinks to main, whose .venv is not installed).
  Run it from minimum B once .venv exists, or hand to codex.
- Or: build a private instrumented agbcc (codegen-notes "Instrumenting agbcc")
  and trace why the cellOff allocno is denied r9 in global_alloc/find_reg even
  though col is dead there — the coalesce condition is the lever.
- Secondary, independent win (58 of the 319): the '|' string scan. Target uses
  goto-test-first (`movs r5,#0; ldr str; b TEST; BODY: len++; TEST: ldr str;
  add len; ldrb; cmp; bne BODY`) with len in r5; agbcc emits a pre-test guard
  + bottom test in r1. `while`/`for` produced identical guarded code; this is
  downstream of the same coloring so it may resolve with the main fix.

## Best-effort C (minimum B, byte_diff 319)

```c
#include "macros.h"
#include "types.h"

#define BG31 0x0600F800
#define BG31_ROW2 0x0600F840
#define BG31_COL2 0x0600F802
#define BG31_ROW2_COL2 0x0600F842

#define WINDOW_TL 0
#define WINDOW_L 1
#define WINDOW_BL 2
#define WINDOW_T 3
#define WINDOW_C 4
#define WINDOW_B 5
#define WINDOW_TR 6
#define WINDOW_R 7
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

    for (i = 0; i < rows2; i++)
        *(u16 *)(BG31_ROW2 + i * 64 + cellOff) = sUiWindowBorderTiles[WINDOW_L];

    *(u16 *)(BG31_ROW2 + rows2 * 64 + (row * 64 + col * 2)) = sUiWindowBorderTiles[WINDOW_BL];

    for (j = 1; j <= width; j++) {
        *(u16 *)(BG31 + j * 2 + (row * 64 + col * 2)) = sUiWindowBorderTiles[WINDOW_T];

        for (i = 0; i < rows2; i++)
            *(u16 *)(BG31_ROW2 + i * 64 + row * 64 + col * 2 + j * 2) = sUiWindowBorderTiles[WINDOW_C];

        *(u16 *)(BG31_ROW2 + (rows2 * 64 + (row * 64 + col * 2)) + j * 2) = sUiWindowBorderTiles[WINDOW_B];

        for (; i > frames; i++)
            sub_080008DC();
    }

    *(u16 *)(BG31_COL2 + width * 2 + row * 64 + col * 2) = sUiWindowBorderTiles[WINDOW_TR];

    for (i = 0; i < rows2; i++)
        *(u16 *)(BG31_ROW2_COL2 + i * 64 + row * 64 + col * 2 + width * 2) = sUiWindowBorderTiles[WINDOW_R];

    *(u16 *)(BG31_ROW2_COL2 + rows2 * 64 + row * 64 + col * 2 + width * 2) = sUiWindowBorderTiles[WINDOW_BR];

    len = 0;
    while (str[len] != '|')
        len++;

    sub_0801C078(str, len, (u8)(col + 1), (u8)(row + 1), 0xa0, 14, 3);
}
```

Makefile flag (required when resuming):
`src/engine/sub_0801cd0c.s: CFLAGS += -fno-strength-reduce`
