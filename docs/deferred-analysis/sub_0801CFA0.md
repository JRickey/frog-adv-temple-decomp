# sub_0801CFA0 — deferred analysis

A tilemap 1x2-tile writer. Picks one of four BG screenblock bases
(0x0600E000 / E800 / F000 / F800, i.e. screenblocks 28-31) from a `screen`
selector, computes a tilemap entry address `base + col*2 + row*64`, and
writes a vertically-adjacent tile pair (top, top+1) with optional H-flip
(bit 0x400) and palette bank (low nibble of arg5 << 12). When `value == 0`
it clears both cells to 0 instead.

## Signature (7 args, last 3 on stack)
```
void sub_0801CFA0(u32 hflip, u8 col, u8 row, u16 tile, u32 pal, u8 screen, u32 value)
```
- arg0 `hflip` -> ip (only tested `!= 0`; selects the 0x400 H-flip bit)
- arg1 `col`   -> r5  (u8; column, *2 = byte offset within a 32-wide map)
- arg2 `row`   -> r2  (u8; row, *64 bytes/row)
- arg3 `tile`  -> r3  (u16; base tile index)
- arg5 `pal`   -> r4  ((arg5 << 28) >> 16 = low-nibble << 12, palette bank)
- arg6 `screen`-> r0  (u8; switch selector 0..3 -> screenblock base in r6)
- arg7 `value` -> r7  (u32; 0 => clear both cells; else the live store guard)

Tile-entry value: hflip!=0 -> `pal + (tile | 0x400)`; hflip==0 -> `pal + tile`.
Second cell (dst+64 bytes) gets entry+1.

## Drift
Best reached: **byte_diff 65, diff_count 31** (out of 160 function bytes),
pure C, `make check` fails (nonmatching) — left in asm, not shipped.

The control-flow STRUCTURE is fully matched: prologue (incl. the
`adds r1, r0, #0` switch-selector copy and the interleaved lsl/lsr arg masks),
the signed 4-way switch (`bgt` binary split, default fall-through), the
`value!=0 { hflip!=0 -> A; B } C` branch layout (A=hflip-set, B=hflip-clear,
C=value==0, in that memory order), and the `(s32)(u8)screen` selector all
reproduce the baserom.

Residual drift is **scratch-register coloring in the three near-identical
address computations** `row*64 + (col*2 + base)`, plus the H-flip OR pattern:

1. **Branch A H-flip OR** (~+0x68): baserom materialises 0x400 into r2 and
   copies tile to r0 first — `movs r0,#128; lsls r0,#3; adds r2,r0,#0;
   adds r0,r3,#0; orrs r0,r2` (3 extra insns). Our agbcc folds it to a single
   in-place `orrs r0,r3` (r0 already holds 0x400). Both preserve tile(r3).
2. **Branch B address** (~+0x88): baserom puts row*64 in r0, col*2 in r1
   (`lsls r0,r2,#6; lsls r1,r5,#1; adds r1,r1,r6; adds r0,r0,r1`); ours swaps
   the two scratch regs (row*64->r1, col*2->r0). Same math, mirrored coloring.
3. **Branch C second store** (~+0x92): baserom mutates the pointer in place
   (`strh r7,[r1]; adds r1,#64; strh r7,[r1]`); ours copies first
   (`adds r0,r1,#0; adds r0,#64`). Driven by which scratch reg the final
   `adds` of the address lands the pointer in.
4. **tile (r3) u16-mask scheduling** (+0x14 vs +0x1c): `lsrs r3,r3,#16` is
   emitted one slot later than baserom — harmless 1-insn reorder.

These are deterministic agbcc local-alloc / evaluation-order choices in three
textually-identical sub-expressions; statement reordering can't reach them.

## Levers already tried (try a DIFFERENT one next)
- Register pins, every combination: col r5 / row r2 / tile r3 / pal r4 /
  screen r0 / value r7 / base r6 — pinning **col and row HURTS** (forces the
  in-place clobber); leaving col/row UNPINNED is what unlocked the matched
  prologue + preserved col across branches. Keep tile=r3, pal=r4, base=r6
  pinned (needed for the stack-arg load order); leave col/row/screen UNPINNED.
- Switch selector: the winning form is `switch ((s32)(u8)screen)` with
  `screen` an unpinned u8 param — this is what produces the signed `bgt` split
  AND the `adds r1,r0,#0` selector copy. A pinned `register s32 screen asm("r0")`
  or a separate `s32 screen` local does NOT emit the copy (-> ~+5 diff).
- Branch layout: `if (value != 0) { if (hflip != 0) A; B; return; } C;`
  is the one that matches the baserom's A,B,C memory order. The flipped
  `if(value==0) C; if(hflip==0) B; A;` puts C first and is worse.
- Address expression: hoisting `dst` once (size 140, < target 168 — can't
  match), and groupings `row*64+(col*2+base)` / `col*2+base+row*64` /
  `base+col*2+row*64` (all tie at 65); `row*64+col*2+base` and
  `base+(row*64+col*2)` are worse (70). Inlining both stores' addresses (no
  `dst` var) recomputes per-store -> 77. `dst[32]` vs `(u8*)dst+64` identical.
- H-flip OR: `pal+(tile|0x400)`, `(tile|0x400)+pal` (tie 65/31 best),
  `pal+tile+0x400` / `pal|tile|0x400` (44 diff_count, worse), splitting the
  OR into its own statement (69), a `u32 flip=0x400` local (no change).
- old_agbcc (per-TU `CC = $(OLD_AGBCC_BIN)`): byte-identical output to agbcc
  here, no help. agbcc rejects `-fno-schedule-insns[2]` (not a recognised flag).
- decomp-permuter: 3 runs (better-only and full anneal, j4, up to 90s each).
  Base score ~11020; best ~4400 but every lower-scoring output was SEMANTICALLY
  INVALID (it inserts a dead `return;` after the switch, or aliases
  `col = value`, to game the scorer). No score-0. The residual is register
  coloring, not statement order, so the permuter cannot reach it.

## Next idea (untried)
The three address calcs differ only in scratch-reg coloring; a fresh angle
would be to read agbcc `gcc_arm/local-alloc.c` / `reload.c` to learn why the
final `adds` of `row*64 + (col*2+base)` lands the pointer in r1 vs r0 per
branch, then force the operand order with a `register u16 *dst asm("r1")` pin
combined with computing `col*2+base` into a pinned scratch BEFORE adding
row*64 — i.e. control which sub-expression is the LHS of the final add in each
branch independently. Also worth trying: make the H-flip bit a value agbcc is
forced to hold in a callee scratch (e.g. derive 0x400 from a switch-invariant
so CSE parks it in r2 like the baserom).

## Best-effort C (pure C, byte_diff 65 / diff_count 31)
```c
#include "macros.h"
#include "types.h"

void sub_0801CFA0(u32 hflip, u8 col, u8 row, u16 tileIn, u32 palIn, u8 screen, u32 value)
{
    register u32 tile asm("r3") = (u16)tileIn;
    register u32 pal asm("r4") = (palIn << 28) >> 16;
    register u32 base asm("r6");
    u16 *dst;
    u32 entry;

    switch ((s32)(u8)screen)
    {
    case 0:
        base = 0x0600E000;
        break;
    case 1:
        base = 0x0600E800;
        break;
    case 2:
        base = 0x0600F000;
        break;
    case 3:
        base = 0x0600F800;
        break;
    }

    if (value != 0)
    {
        if (hflip != 0)
        {
            dst = (u16 *)(row * 64 + (col * 2 + base));
            entry = pal + (tile | 0x400);
            dst[0] = entry;
            dst[32] = entry + 1;
            return;
        }

        dst = (u16 *)(row * 64 + (col * 2 + base));
        entry = pal + tile;
        dst[0] = entry;
        dst[32] = entry + 1;
        return;
    }

    dst = (u16 *)(row * 64 + (col * 2 + base));
    dst[0] = value;
    dst[32] = value;
}
```
