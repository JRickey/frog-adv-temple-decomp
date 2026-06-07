#include "gba/dma.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"

extern void Tilemap_SwapPalette(u32 *attr, u16 arg1, u16 arg2, u8 arg3);

void FrogSelect_LoadCharTilemap(void)
{
    volatile DmaChannel *dma;
    u32 tableBase;
    u32 attr;

    attr = (attr & 0xffffff00) | 0x09;
    attr = (attr & 0xffff00ff) | 0x0600;
    attr = (attr & 0x00ffffff) | 0x03000000;
    attr = (attr & 0xff00ffff) | 0x000e0000;

    switch (gIwram_3480.cursorIndex) {
    case 0:
        attr = (attr & 0xffff00ff) | 0x0500;
        break;
    case 1:
        attr = (attr & 0xffff00ff) | 0x0900;
        break;
    case 2:
        attr = (attr & 0xffff00ff) | 0x0d00;
        break;
    }

    dma = &REG_DMA3;
    tableBase = 0x08308f70;
    /* Anchor the ROM table literal so agbcc materializes the DMA base then the
       table base into registers before loading the gIwram_34B0 index. Without
       the fence agbcc's EXPAND_SUM keeps the table constant deferred and folds
       its load after the index. Same idiom as GetHighestUnlockedWorld / Credits_InitStateA. */
    asm volatile("" : "+r"(tableBase));
    dma->src = (const void *)*(const u32 *)(tableBase + gIwram_34B0._data * 4);
    dma->dst = (void *)0x0600f000;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    Tilemap_SwapPalette(&attr, 5, 4, 2);
}

extern u32 GetFrameTick(void);

void FrogSelect_InitDispatch(void)
{
    gIwram_3480.lastAdvanceTick = GetFrameTick();
    Screen_BeginFlash(0xBF);

    gIwram_3470[0] = 0;
    gIwram_3470[1] = 0;
    gIwram_3470[3] = 0xA0;
    gIwram_3470[2] = 0xF0;

    gIwram_3550._data[0] = 0;
    gIwram_3550._data[1] = 0;

    gIwram_3480.menu25Step++;
    gIwram_34A0.dispatchIdx = 0;
}
