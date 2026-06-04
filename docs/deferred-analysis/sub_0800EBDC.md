# sub_0800EBDC — deferred (round 33)

Per-scene scroll commit + visible-screenblock blit. ~225 Thumb instructions,
600 bytes of asm slice [0x0800ebdc, 0x0800ee34). The slice also carries a
trivial second function sub_0800EE0C (REG_BLDCNT/REG_BLDALPHA setter) which IS
trivially matchable — see "## Best-effort C".

## Semantics (fully reverse-engineered, high confidence)
`void sub_0800EBDC(u8 count)`. For each of `count` SceneScrollState entries at
0x030060A0 (stride 0x20 — same layout sub_0800F2F8 / sub_0801A6D4 use):
  - struct fields: +0x04 committedX, +0x08 committedY, +0x0c scrollX,
    +0x10 scrollY, +0x14 bgHofs, +0x16 bgVofs, +0x18 tileHeight, +0x1a tileWidth.
  1. commit: committedX = scrollX; committedY = scrollY.
  2. derive source tile coords: srcRow from scrollY, srcCol from scrollX, each
     clamped: if scrollY in (47, (tileH<<3)-0xD0] -> srcRow=(scrollY-0x30)>>3
     (signed /8); else if scrollY > that limit && tileH>31 -> srcRow=tileH-32.
     Symmetric for srcCol with scrollX, 0xF8, 8. Also publishes
     bgVofs=scrollY, bgHofs=scrollX.
  3. dispatch on i (0/1/2) -> (srcEwram, dstVram, gIwram_3550._data pair):
     i=0: 0x02000000 / 0x0600E000 / _data[0..1]=ss[0].bgHofs/bgVofs
     i=1: 0x02010000 / 0x0600E800 / _data[2..3]=ss[1] (read via 0x030060C0)
     i=2: 0x02020000 / 0x0600F000 / _data[4..5]=ss[2] (read via 0x030060E0)
  4. 32x32-tile halfword blit from EWRAM map buffer to VRAM screenblock:
     src = srcEwram + (srcRow*tileWidth + srcCol)*2
     dst = dstVram + (srcRow&31)*0x40 + (srcCol&31)*2
     colSpan = 32 - (srcCol&31)
     outer 32 rows, inner 32 cols; per store: wrap dst at +0x800 screenblock
     boundary (dst = dstVram + (((dst-0x800-dstVram)>>1)<<1)), and when the
     per-row colSpan counter hits 0 wrap the column (dst-=0x40; if <dstVram
     dst=dstVram+0x7C0). After each row src += tileWidth*2 - 0x40, and if
     colSpan!=32 dst += 0x40.

## Drift (why it does NOT match — corpus-confirmed hard class)
Four structurally-distinct C shapes were tried; ALL land at "fundamentally
different codegen", not a near-match:
  - v1 single `st = &gIwram_60A0[i]` struct pointer:        byte_diff 403, diff 255
  - v2 raw `base+fieldoff+off` arithmetic, 2 anchors:        byte_diff 441, diff 231
  - v3 do-while + struct pointer, count on stack (cleanest): byte_diff 416, diff 291
  - v4 macro raw-arith, minimized locals:                    byte_diff 454, diff 303
(total instructions ~225, so diff_count > instr count = almost nothing aligns.)

Root cause: the baserom keeps the bare entry base 0x030060A0 in **ip (r12)**,
RELOADED from a pool literal at the top of EVERY iteration, and recomputes each
field address as `ip + fieldoff + off` (mov r1,ip; adds r1,#K; adds r1,r3,r1).
It never forms a single induction pointer. The loop index is in **r9**, count
lives on the **stack** ([sp,#0]) and is reloaded for each `cmp r9,[sp]` check,
srcRow/srcCol are in callee-saved **sl/r7**, and the loop increment is hoisted
into sl mid-body (`sl=i+1`) then applied at loop-end (`i=(u8)sl`).

agbcc 2.x given any natural C instead forms `st = base+off` once (low reg r4)
and reuses it, or reloads the literal into low regs — it never emits the
`mov ip, <base>` anchor + per-access recompute. Corpus census confirms this is
NOT a local-coloring miss but a genuine codegen-shape gap:
  `corpus.py grep 'mov +ip, *r[0-9]' --c` -> EVERY hit (boktai2, mzm/mf,
  mother3, rmz3, fireemblem8u, pokeemerald) is inside an inline-asm string
  ("mov ip, r2\n\") — i.e. hand-asm. History search (metroidret/mzm
  f49762944c, c1b6184564, 10f0d2601b) shows `mov ip` only ever
  removed-as-asm / re-added inside NAKED_FUNCTION blocks, never produced from
  plain C. So the ip-anchor-reload idiom appears unreachable from agbcc C.

This is the "high register holding loop state across recomputation" hard class
(docs/codegen-notes "High registers ... usually MATCHABLE" lists straight-line
cases as matchable, but the per-iteration ip-base-reload + index recompute is
the narrow genuinely-hard variant). It is NOT class3-libgcc STRONG_UNMATCHABLE,
so per the asymmetric-cost rule it was NOT shipped NAKED — deferred instead.

Levers NOT yet tried (for the next attempt): (a) instrument agbcc's
local-alloc.c / reload.c to see why it refuses ip for the base across the loop
(ip is 5th in REG_ALLOC_ORDER and call-used, and there are no calls here, so it
*should* be eligible); (b) a linker-assigned symbol pair gIwram_60A0/gIwram_60AC
was added (kept — see linker.ld) but did not by itself trigger the ip anchor;
(c) permuter from the v3 base (byte_diff 416 is well above the ~40 permuter
sweet spot, so likely fruitless until a near-match exists); (d) -ffixed-rN to
starve low regs and force ip.

## Best-effort C
```c
/* do-while + struct-pointer shape (v3), cleanest readable form; byte_diff 416.
 * sub_0800EE0C (the trivial second fn in the slice) DOES match as plain C. */
#include "iwram.h"
#include "types.h"

enum { SCROLL_Y_MIN = 47, SCROLL_X_MIN = 7, TILE_PIXELS_SHIFT = 3,
       SCREEN_TILES = 32, SCREENBLOCK_BYTES = 0x800, ROW_BYTES = 0x40 };

struct SceneScrollState_EBDC {
    u8 _pad00[4];
    s32 committedX; s32 committedY; s32 scrollX; s32 scrollY;
    u16 bgHofs; u16 bgVofs; u16 tileHeight; u16 tileWidth;
    u8 _pad1c[4];
};
extern struct SceneScrollState_EBDC gIwram_60A0;
extern s32 gIwram_60AC;

void sub_0800EBDC(u8 countArg)
{
    u8 count;
    register u32 i asm("r9");
    register s32 srcRow asm("sl");
    s32 srcCol;
    register u32 dstVram asm("r8");

    count = countArg;
    i = 0;
    if (i >= count) return;
    do {
        struct SceneScrollState_EBDC *base = &gIwram_60A0;
        u32 off = i * sizeof(struct SceneScrollState_EBDC);
        struct SceneScrollState_EBDC *st = (struct SceneScrollState_EBDC *)((u32)base + off);
        s32 limit; u32 srcEwram; u16 *src; u16 *dst; s32 colSpan; s32 row; u16 *shadow;

        st->committedX = *(s32 *)((u32)&gIwram_60AC + off);
        st->committedY = st->scrollY;
        srcCol = 0; srcRow = 0;
        limit = (st->tileHeight << TILE_PIXELS_SHIFT) - 0xD0;
        if (st->scrollY > SCROLL_Y_MIN && st->scrollY <= limit)
            srcRow = (st->scrollY - 0x30) >> TILE_PIXELS_SHIFT;
        st->bgVofs = st->scrollY;
        if (st->scrollY > limit && st->tileHeight > 31)
            srcRow = st->tileHeight - SCREEN_TILES;
        limit = (st->tileWidth << TILE_PIXELS_SHIFT) - 0xF8;
        if (st->scrollX > SCROLL_X_MIN && st->scrollX <= limit)
            srcCol = (st->scrollX - 8) >> TILE_PIXELS_SHIFT;
        st->bgHofs = st->scrollX;
        if (st->scrollX > limit && st->tileWidth > 31)
            srcCol = st->tileWidth - SCREEN_TILES;

        shadow = gIwram_3550._data;
        switch (i) {
        case 0: srcEwram = 0x02000000; dstVram = 0x0600E000;
            shadow[1] = base->bgVofs; shadow[0] = base->bgHofs; break;
        case 1: srcEwram = 0x02010000; dstVram = 0x0600E800;
            shadow[3] = ((struct SceneScrollState_EBDC *)0x030060C0)->bgVofs;
            shadow[2] = ((struct SceneScrollState_EBDC *)0x030060C0)->bgHofs; break;
        case 2: srcEwram = 0x02020000; dstVram = 0x0600F000;
            shadow[5] = ((struct SceneScrollState_EBDC *)0x030060E0)->bgVofs;
            shadow[4] = ((struct SceneScrollState_EBDC *)0x030060E0)->bgHofs; break;
        }

        src = (u16 *)(srcEwram + (srcRow * st->tileWidth) * 2 + srcCol * 2);
        dst = (u16 *)(dstVram + (srcRow & 31) * ROW_BYTES + (srcCol & 31) * 2);
        colSpan = (u16)(SCREEN_TILES - (srcCol & 31));
        for (row = 1;; row++) {
            s32 col; s32 remain = colSpan;
            for (col = 0;; col++) {
                if (dst >= (u16 *)(dstVram + SCREENBLOCK_BYTES))
                    dst = (u16 *)(dstVram + ((((u32)dst - SCREENBLOCK_BYTES - dstVram) >> 1) << 1));
                if (remain == 0) {
                    dst = (u16 *)((u32)dst - ROW_BYTES);
                    if ((u32)dst < dstVram) dst = (u16 *)(dstVram + 0x7C0);
                }
                *dst++ = *src++;
                remain = (u16)(remain - 1);
                if ((u16)col >= 31) break;
            }
            src = (u16 *)((u32)src + st->tileWidth * 2 - ROW_BYTES);
            if (colSpan != SCREEN_TILES) dst = (u16 *)((u32)dst + ROW_BYTES);
            if ((u16)row >= 31) break;
        }
        i = (u8)(i + 1);
    } while (i < count);
}

void sub_0800EE0C(u16 targets, u16 coeff)
{
    *(vu16 *)0x04000050 = targets | 0x1740;  /* REG_BLDCNT  |= 0x1740 | targets */
    *(vu16 *)0x04000052 = coeff;             /* REG_BLDALPHA = coeff */
}
```
