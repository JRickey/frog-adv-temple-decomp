#include "iwram.h"
#include "gfx.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

extern const void *const sUiAssetSlots[];

extern u32 GetFrameTick(void);
extern s32 Screen_TickFlash(void);
extern void Mode4_BlitRect(u16 dstX, u16 dstY, const void *src, void *desc);
extern void Sound_Reset(void);

/* Title/attract input poll + auto-advance. Latches just-pressed keys into
 * gIwram_5358, then bails while a fade-out (Screen_TickFlash) is still running.
 * Pressing A advances the attract step (_data[3]); otherwise the step
 * auto-advances once more than 0x383 ticks have elapsed since the last
 * advance. Each advance restarts the fade-in (Blend_StartFade). Sibling of
 * CreditsMenu_HandleInputB, which advances _data[4] on a 0x257-tick timer. */
void CreditsMenu_HandleInputA(void)
{
    u16 raw;
    u32 now;

    raw = ~REG_KEYINPUT;
    gIwram_5358.justPressed = raw & ~gIwram_3710.prevKeys;
    gIwram_3710.prevKeys = raw;

    if (Screen_TickFlash() != 0)
        return;

    if (gIwram_5358.justPressed & KEY_A) {
        gIwram_3480._data[3]++;
        Blend_StartFade(0xBF);
        return;
    }

    now = GetFrameTick();
    if (now - gIwram_3480._unk0C <= 0x383)
        return;

    gIwram_3480._unk0C = GetFrameTick();
    gIwram_3480._data[3]++;
    Blend_StartFade(0xBF);
}

/* Enters bitmap mode 4 and blits the next attract frame: timestamps the
 * advance, kicks a fade-out, primes the gIwram_3470 blit descriptor
 * (full-screen 0xF0 x 0xA0), DMAs the palette (sUiAssetSlots[52]) and
 * blits the pixels (sUiAssetSlots[51]) into the back buffer, then flips
 * the bitmap frame-select bit and advances _data[4]. */
void CreditsScreen_Init(void)
{
    volatile DmaChannel *dma;

    gIwram_3480._unk0C = GetFrameTick();
    Screen_BeginFlash(0xBF);

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

    Mode4_BlitRect(0, 0, sUiAssetSlots[51], gIwram_3470);

    REG_DISPCNT ^= DISPCNT_FRAME1;
    Sound_Reset();

    gIwram_3480._data[4]++;
}

/* Same attract auto-advance as CreditsMenu_HandleInputA, but drives _data[4] on a
 * shorter 0x257-tick timer. */
void CreditsMenu_HandleInputB(void)
{
    u16 raw;
    u32 now;

    raw = ~REG_KEYINPUT;
    gIwram_5358.justPressed = raw & ~gIwram_3710.prevKeys;
    gIwram_3710.prevKeys = raw;

    if (Screen_TickFlash() != 0)
        return;

    if (gIwram_5358.justPressed & KEY_A) {
        gIwram_3480._data[4]++;
        Blend_StartFade(0xBF);
        return;
    }

    now = GetFrameTick();
    if (now - gIwram_3480._unk0C <= 0x257)
        return;

    gIwram_3480._unk0C = GetFrameTick();
    gIwram_3480._data[4]++;
    Blend_StartFade(0xBF);
}

/* Clears screenblock 28 via DMA3 from a stack zero, then sets up
 * DISPCNT + BGxCNT and zeroes the BG scroll-offset shadow and MMIO. */
void Bg_InitMode0(void)
{
    volatile DmaChannel *dma;
    volatile u16 zero; /* volatile prevents r2 from surviving as a live zero register,
                        * freeing it for the BGxCNT value walk (r2 = 0x1c03..0x1f00) */

    zero = 0;
    dma = &REG_DMA3;
    dma->src = (const void *)&zero;
    dma->dst = (void *)0x0600e000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x1000;
    (void)dma->cnt;

    REG_DISPCNT = DISPCNT_BG0_ON | DISPCNT_BG2_ON;

    REG_BG0CNT = 0x1c03;
    REG_BG1CNT = 0x1d02;
    REG_BG2CNT = 0x1e01;
    REG_BG3CNT = 0x1f00;

    gIwram_3550._data[0] = 0;
    gIwram_3550._data[1] = 0;
    gIwram_3550._data[2] = 0;
    gIwram_3550._data[3] = 0;
    gIwram_3550._data[4] = 0;
    gIwram_3550._data[5] = 0;

    *(vu16 *)0x04000010 = 0;
    *(vu16 *)0x04000012 = 0;
    *(vu16 *)0x04000014 = 0;
    *(vu16 *)0x04000016 = 0;
    *(vu16 *)0x04000018 = 0;
    *(vu16 *)0x0400001a = 0;
    *(vu16 *)0x0400001c = 0;
    *(vu16 *)0x0400001e = 0;
}
