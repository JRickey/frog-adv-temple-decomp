#include "types.h"
#include "gba/intr.h"
#include "gba/io.h"

extern u16 gIwram_3550;
extern u8 gIwram_3610;
extern u8 gIwram_53A0;

#define BG_SCROLL_BASE    ((u16 *)&gIwram_3550)
#define BG0_RASTER_SCROLL (&gIwram_53A0)
#define BG1_RASTER_SCROLL (&gIwram_3610)

void sub_0800088C(void)
{
    u8 scanline;
    register vu16 *dst asm("r1");
    register u16 *bgScrollBase asm("r2");

    scanline = (u8)REG_VCOUNT;
    if (scanline > 0xe3) {
        REG_IF = IRQ_HBLANK;
        return;
    }

    dst = (vu16 *)0x04000010;
    bgScrollBase = BG_SCROLL_BASE;
    *dst = bgScrollBase[0] + *(u8 *)(scanline + (s32)BG0_RASTER_SCROLL);
    dst += 2;
    *dst = bgScrollBase[2] + *(u8 *)(scanline + (s32)BG1_RASTER_SCROLL);
    REG_IF = IRQ_HBLANK;
}
