#include "gba/dma.h"
#include "macros.h"
#include "types.h"

/* Mode 4 row-blit helpers (frame page 0 / page 1), siblings of Mode4_BlitRect:
 * DMA `desc->rows` rows of `desc->width` bytes from a packed source to VRAM,
 * 240-byte screen stride, no DISPCNT page check.
 *
 * NON_MATCHING: the structure is byte-exact; only a low-register coloring +
 * instruction-scheduling divergence blocks the final few instructions (m2c gave
 * the structure, but agbcc colours/schedules the dst/srcRow setup differently).
 * decomp-permuter with NO pins (~73k iters) drove sub_080162FC to score 20
 * (≈1 register off) via two source mutations worth re-trying first next session:
 *   1. reassociate dst:  ((u32)dstY*240 + page) + dstX   (add dstX last)
 *   2. split the srcRow declaration from its assignment.
 * sub_0801629C plateaued at score 235. The NAKED .incbin below provides the
 * matching bytes until a future pass lands the pure-C match. */

struct Mode4BlitRect {
    u8 x;
    u8 y;
    u8 width;
    u8 rows;
};

#ifdef NON_MATCHING
void sub_0801629C(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    u8 *dst = (u8 *)(dstX + ((u32)dstY * 240 + 0x06000000));
    u8 *srcRow = (u8 *)(desc->x + ((u32)src + (u32)desc->y * 240));
    u16 i;

    for (i = 0; i < desc->rows; i = (u16)(i + 1)) {
        REG_DMA3.src = srcRow;
        REG_DMA3.dst = dst;
        REG_DMA3.cnt = DMA_ENABLE | (desc->width >> 1);
        (void)REG_DMA3.cnt;
        srcRow += 240;
        dst += 240;
    }
}

void sub_080162FC(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    u8 *dst = (u8 *)(dstX + ((u32)dstY * 240 + 0x0600A000));
    u8 *srcRow = (u8 *)(desc->x + ((u32)src + (u32)desc->y * 240));
    u16 i;

    for (i = 0; i < desc->rows; i = (u16)(i + 1)) {
        REG_DMA3.src = srcRow;
        REG_DMA3.dst = dst;
        REG_DMA3.cnt = DMA_ENABLE | (desc->width >> 1);
        (void)REG_DMA3.cnt;
        srcRow += 240;
        dst += 240;
    }
}
#else
NAKED void sub_0801629C(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x1629c, 0x60\n");
}

NAKED void sub_080162FC(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x162fc, 0x64\n");
}
#endif /* NON_MATCHING */
