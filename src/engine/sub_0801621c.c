#include "gba/dma.h"
#include "gba/io.h"
#include "types.h"

#define DISPCNT_FRAME1 (1U << 4)

struct BlitDesc {
    u8 x;
    u8 y;
    u8 width;
    u8 rows;
};

void Mode4_BlitRect(u16 dstX, u16 dstY, u8 *src, struct BlitDesc *desc)
{
    register u8 *dst asm("r2");
    u8 *srcBase;
    u8 *srcRow;
    u32 base;
    u16 i;

    if (REG_DISPCNT & DISPCNT_FRAME1)
        base = 0x06000000 + (u32)dstY * 240;
    else
        base = 0x0600A000 + (u32)dstY * 240;
    dst = (u8 *)(dstX + base);

    {
        register u32 rowOff asm("r0");
        register u32 x asm("r7");

        rowOff = (u32)desc->y * 240;
        srcBase = src + rowOff;
        x = desc->x;
        srcRow = (u8 *)(x + (u32)srcBase);
    }

    for (i = 0; i < desc->rows; i = (u16)(i + 1)) {
        REG_DMA3.src = srcRow;
        REG_DMA3.dst = dst;
        REG_DMA3.cnt = DMA_ENABLE | (desc->width >> 1);
        (void)REG_DMA3.cnt;
        srcRow += 240;
        dst += 240;
    }
}
