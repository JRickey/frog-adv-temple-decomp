#include "gba/dma.h"
#include "gfx.h"
#include "gba/io.h"
#include "types.h"

extern const u16 sScreenPaletteCD78[256];
extern const u16 sScreenTilemapCF78[1024];
extern void WaitFrames(u32 delay);
extern s32 Blend_StepFade(void);

void Credits_FadeTransition(void)
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

    Screen_BeginFlash(0xBF);
    while (Screen_TickFlash() != 0)
        WaitFrames(2);

    WaitFrames(0x168);
    Blend_StartFade(0xBF);
    while (Blend_StepFade() != 0)
        WaitFrames(2);
}
