#include "types.h"
#include "gba/dma.h"

extern const u8 sLevelClearedLabels[124];

extern void DrawTextGlyphs(const u8 *str, int x, int y, int a, int b, int c, int d);

void LevelCleared_ShowExtLabel(void)
{
    DrawTextGlyphs(&sLevelClearedLabels[8], 8, 11, 10, 278, 14, 3);
}

void Screen_ClearRect(u32 data, u8 screen)
{
    u32 base;
    u8 i;
    u16 zero;

    switch ((s32)(u8)screen) {
    case 0:
        base = 0x0600e000;
        break;
    case 1:
        base = 0x0600e800;
        break;
    case 2:
        base = 0x0600f000;
        break;
    case 3:
        base = 0x0600f800;
        break;
    }

    i = 0;
    if (i < (u8)(data >> 24)) {
        u16 *zerop = &zero;
        volatile DmaChannel *dma = &REG_DMA3;
        base += (data << 24) >> 23;
        do {
            *(volatile u16 *)zerop = 0;
            {
                register u32 dataAlias asm("r2") = data;
                data = dataAlias;
            }
            dma->src = &zero;
            dma->dst = (void *)(base + ((u8)(data >> 8) + i) * 64);
            dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | (u8)(data >> 16);
            (void)dma->cnt;
            i = (u8)(i + 1);
        } while (i < (u8)(data >> 24));
    }
}
