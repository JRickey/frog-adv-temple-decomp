#include "gba/dma.h"
#include "macros.h"
#include "types.h"

/* Transparent Mode 4 row-blit helpers (frame page 0 / page 1): for each row, DMA
 * the destination VRAM row into a stack buffer, overlay the non-zero source
 * bytes (transparency), then DMA the buffer back. Source rows are packed at
 * `desc->width` stride; the scratch buffer is a VLA of (width+3)&~3 bytes.
 *
 * NON_MATCHING: structure is correct but these use high registers (r8/r9/sl)
 * whose allocation diverges from the baserom, plus the VLA stack setup. With NO
 * pins, decomp-permuter (~64k iters) only reached score 870 (sub_08015EC4) /
 * 1145 (sub_08015F9C) — far from a match; these likely need explicit register
 * pins or a separate-TU `-fno-schedule-insns`, deferred to a future session.
 * The NAKED .incbin below provides the matching bytes meanwhile. */

struct Mode4BlitRect {
    u8 x;
    u8 y;
    u8 width;
    u8 rows;
};

#ifdef NON_MATCHING
void sub_08015EC4(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    u8 buf[(desc->width + 3) & ~3];
    u8 *dst = (u8 *)(dstX + ((u32)dstY * 240 + 0x06000000));
    u8 *srcRow = (u8 *)(desc->x + ((u32)src + (u32)desc->y * desc->width));
    u16 i;

    for (i = 0; i < desc->rows; i = (u16)(i + 1)) {
        u16 j;

        REG_DMA3.src = dst;
        REG_DMA3.dst = buf;
        REG_DMA3.cnt = DMA_ENABLE | (desc->width >> 1);

        for (j = 0; j < desc->width; j = (u16)(j + 1)) {
            u8 px = srcRow[j];
            if (px != 0)
                buf[j] = px;
        }

        REG_DMA3.src = buf;
        REG_DMA3.dst = dst;
        REG_DMA3.cnt = DMA_ENABLE | (desc->width >> 1);
        srcRow += desc->width;
        dst += 240;
    }
}

void sub_08015F9C(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    u8 buf[(desc->width + 3) & ~3];
    u8 *dst = (u8 *)(dstX + ((u32)dstY * 240 + 0x0600A000));
    u8 *srcRow = (u8 *)(desc->x + ((u32)src + (u32)desc->y * desc->width));
    u16 i;

    for (i = 0; i < desc->rows; i = (u16)(i + 1)) {
        u16 j;

        REG_DMA3.src = dst;
        REG_DMA3.dst = buf;
        REG_DMA3.cnt = DMA_ENABLE | (desc->width >> 1);

        for (j = 0; j < desc->width; j = (u16)(j + 1)) {
            u8 px = srcRow[j];
            if (px != 0)
                buf[j] = px;
        }

        REG_DMA3.src = buf;
        REG_DMA3.dst = dst;
        REG_DMA3.cnt = DMA_ENABLE | (desc->width >> 1);
        srcRow += desc->width;
        dst += 240;
    }
}
#else
NAKED void sub_08015EC4(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x15ec4, 0xd8\n");
}

NAKED void sub_08015F9C(u16 dstX, u16 dstY, u8 *src, struct Mode4BlitRect *desc)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x15f9c, 0xd8\n");
}
#endif /* NON_MATCHING */
