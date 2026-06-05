#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

extern const void *const sUiAssetSlots[];

extern u32 sub_08000900(void);
extern s32 sub_08010710(void);
extern u16 sub_08010694(u16 arg);
extern u16 sub_080106EC(u16 arg);
extern void sub_0801621C(u16 dstX, u16 dstY, const void *src, void *desc);
extern void sub_0802D8F8(void);

/* Title/attract input poll + auto-advance. Latches just-pressed keys into
 * gIwram_5358, then bails while a fade-out (sub_08010710) is still running.
 * Pressing A advances the attract step (_data[3]); otherwise the step
 * auto-advances once more than 0x383 ticks have elapsed since the last
 * advance. Each advance restarts the fade-in (sub_08010694). Sibling of
 * sub_080183D0, which advances _data[4] on a 0x257-tick timer. */
void sub_080182CC(void)
{
    u16 raw;
    u32 now;

    raw = ~REG_KEYINPUT;
    gIwram_5358.justPressed = raw & ~gIwram_3710.prevKeys;
    gIwram_3710.prevKeys = raw;

    if (sub_08010710() != 0)
        return;

    if (gIwram_5358.justPressed & KEY_A) {
        gIwram_3480._data[3]++;
        sub_08010694(0xBF);
        return;
    }

    now = sub_08000900();
    if (now - gIwram_3480._unk0C <= 0x383)
        return;

    gIwram_3480._unk0C = sub_08000900();
    gIwram_3480._data[3]++;
    sub_08010694(0xBF);
}

/* Enters bitmap mode 4 and blits the next attract frame: timestamps the
 * advance, kicks a fade-out, primes the gIwram_3470 blit descriptor
 * (full-screen 0xF0 x 0xA0), DMAs the palette (sUiAssetSlots[52]) and
 * blits the pixels (sUiAssetSlots[51]) into the back buffer, then flips
 * the bitmap frame-select bit and advances _data[4]. */
void sub_08018348(void)
{
    volatile DmaChannel *dma;

    gIwram_3480._unk0C = sub_08000900();
    sub_080106EC(0xBF);

    gIwram_3470[0] = 0;
    gIwram_3470[1] = 0;
    gIwram_3470[3] = 0xA0;
    gIwram_3470[2] = 0xF0;

    REG_BG2CNT = 0;
    REG_DISPCNT = DISPCNT_BG2_ON | 4;

    dma = &REG_DMA3;
    dma->src = sUiAssetSlots[52];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    sub_0801621C(0, 0, sUiAssetSlots[51], gIwram_3470);

    REG_DISPCNT ^= DISPCNT_FRAME1;
    sub_0802D8F8();

    gIwram_3480._data[4]++;
}

/* Same attract auto-advance as sub_080182CC, but drives _data[4] on a
 * shorter 0x257-tick timer. */
void sub_080183D0(void)
{
    u16 raw;
    u32 now;

    raw = ~REG_KEYINPUT;
    gIwram_5358.justPressed = raw & ~gIwram_3710.prevKeys;
    gIwram_3710.prevKeys = raw;

    if (sub_08010710() != 0)
        return;

    if (gIwram_5358.justPressed & KEY_A) {
        gIwram_3480._data[4]++;
        sub_08010694(0xBF);
        return;
    }

    now = sub_08000900();
    if (now - gIwram_3480._unk0C <= 0x257)
        return;

    gIwram_3480._unk0C = sub_08000900();
    gIwram_3480._data[4]++;
    sub_08010694(0xBF);
}
