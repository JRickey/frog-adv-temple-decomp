#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

extern const void *const sUiAssetSlots[];

/* Fade-in ticker — returns the post-decrement countdown (non-zero while
 * the previous fade is still running). Declared s32 (canonical type u8)
 * so agbcc compares the return directly with `cmp r0, #0`. */
extern s32 Blend_StepFade(void);
extern s32 Screen_TickFlash(void);
extern u16 Screen_BeginFlash(u16 arg);
extern u16 Blend_StartFade(u16 arg);
extern void WaitFrames(u32 delay);

/* Status-bar reload + forced fade cycle. Bails while the fade-in ticker
 * (Blend_StepFade) is still counting down; otherwise reloads the BG3
 * status-bar graphics (DMA3 from sUiAssetSlots[12..14] into tile/palette/
 * map VRAM), kicks off a fade-out (Screen_BeginFlash), spins until it
 * completes, holds for 0x78 frames, then starts a fade-in (Blend_StartFade)
 * and spins until that finishes. Clears the scene-dispatch selector at
 * the end. Class-sibling of Menu25_ReloadStatusBarBg, which does the same DMA3
 * sequence with sUiAssetSlots[3..5] but no busy-wait. */
void TitleLogo_Display(void)
{
    volatile DmaChannel *dma;
    s32 ticker;

    if (Blend_StepFade() != 0)
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

    Screen_BeginFlash(0xBF);

    while (Screen_TickFlash() != 0)
        WaitFrames(2);

    WaitFrames(0x78);
    Blend_StartFade(0xBF);

    while ((ticker = Blend_StepFade()) != 0)
        WaitFrames(2);

    gIwram_34A0.dispatchIdx = ticker;
}

void Menu25_InitKeyTable(void)
{
    u8 *table = (u8 *)0x030053A0;
    register u32 zero asm("r3") = 0;
    register u32 value asm("r1") = 1;
    u8 *state;
    u32 zero2;
    u32 mask;

    table[0] = value;
    table[1] = value;
    value = 2;
    table[2] = value;
    table[3] = value;
    zero2 = 4;
    table[4] = zero2;
    value = 8;
    table[5] = value;
    table[6] = zero2;
    table[7] = value;
    zero2 = 0x20;
    table[8] = zero2;
    value = 0x10;
    table[9] = value;
    table[10] = zero2;
    table[11] = value;

    state = (u8 *)0x03005330;
    zero2 = 0;
    *(u16 *)(state + 0x22) = zero;
    table = state;
    table += 0x20;
    *table = zero2;
    state[0x10] = zero2;
    mask = 0xfb;
    zero2 = state[0x18];
    mask &= zero2;
    state[0x18] = mask;
}
