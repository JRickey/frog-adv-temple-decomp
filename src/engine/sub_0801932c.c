#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

extern const void *const sUiAssetSlots[];

/* Fade-in ticker — returns the post-decrement countdown (non-zero while
 * the previous fade is still running). Declared s32 (canonical type u8)
 * so agbcc compares the return directly with `cmp r0, #0`. */
extern s32 sub_080106B8(void);
extern s32 sub_08010710(void);
extern u16 sub_080106EC(u16 arg);
extern u16 sub_08010694(u16 arg);
extern void sub_0801E270(u32 delay);

/* Status-bar reload + forced fade cycle. Bails while the fade-in ticker
 * (sub_080106B8) is still counting down; otherwise reloads the BG3
 * status-bar graphics (DMA3 from sUiAssetSlots[12..14] into tile/palette/
 * map VRAM), kicks off a fade-out (sub_080106EC), spins until it
 * completes, holds for 0x78 frames, then starts a fade-in (sub_08010694)
 * and spins until that finishes. Clears the scene-dispatch selector at
 * the end. Class-sibling of sub_080195C4, which does the same DMA3
 * sequence with sUiAssetSlots[3..5] but no busy-wait. */
void sub_0801932C(void)
{
    volatile DmaChannel *dma;
    s32 ticker;

    if (sub_080106B8() != 0)
        return;

    REG_BG3CNT = 0x1E08;

    dma = &REG_DMA3;
    dma->src = sUiAssetSlots[12];
    dma->dst = (void *)0x06008000;
    dma->cnt = DMA_ENABLE | 0x290;
    (void)dma->cnt;

    dma->src = sUiAssetSlots[13];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    dma->src = sUiAssetSlots[14];
    dma->dst = (void *)0x0600F000;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    REG_DISPCNT = DISPCNT_BG3_ON;

    sub_080106EC(0xBF);

    while (sub_08010710() != 0)
        sub_0801E270(2);

    sub_0801E270(0x78);
    sub_08010694(0xBF);

    while ((ticker = sub_080106B8()) != 0)
        sub_0801E270(2);

    gIwram_34A0.dispatchIdx = ticker;
}
