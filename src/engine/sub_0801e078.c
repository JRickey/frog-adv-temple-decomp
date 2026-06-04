#include "gba/dma.h"
#include "gba/io.h"
#include "types.h"

extern const u16 sScreenPaletteCD78[256];
extern const u16 sScreenTilemapCF78[1024];
extern u16 sub_080106EC(u16 arg);
extern s32 sub_08010710(void);
extern void sub_0801E270(u32 delay);
extern u8 sub_08010694(u8 arg);
extern s32 sub_080106B8(void);

void sub_0801E078(void)
{
    volatile DmaChannel *dma;

    REG_DISPCNT = DISPCNT_BG0_ON;
    REG_BG0CNT = 0x1C83;

    dma = &REG_DMA3;
    dma->src = (const void *)0x0820D778;
    dma->dst = (void *)0x06000000;
    dma->cnt = DMA_ENABLE | 0x4000;
    (void)dma->cnt;

    dma->src = sScreenPaletteCD78;
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    dma->src = sScreenTilemapCF78;
    dma->dst = (void *)0x0600E000;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    sub_080106EC(0xBF);
    while (sub_08010710() != 0)
        sub_0801E270(2);

    sub_0801E270(0x168);
    sub_08010694(0xBF);
    while (sub_080106B8() != 0)
        sub_0801E270(2);
}
