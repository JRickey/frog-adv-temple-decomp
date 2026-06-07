#include "game.h"
#include "gfx.h"
#include "types.h"
#include "gba/dma.h"

extern void Credits_Init(u8 arg);
extern void Credits_LoadBgGfx(u8 arg);
extern void WaitFrames(u32 delay);
extern s32 Screen_TickFlash(void);
extern void IrisOpen(u8 a, u8 b);
extern void Credits_LoadFrogGfx(u8 arg);
extern void Credits_InitScrollPage1(u8 arg);
extern u16 Input_Poll(void);
extern u8 Credits_Tick(u8 arg);
extern void IrisClose(u8 a, u8 b);
extern s32 Blend_StepFade(void);
extern u8 Credits_ScrollTick(u8 arg);

/* Scene transition: fade the screen out, swap room state, then fade back
 * in. Screen_BeginFlash/Screen_TickFlash drive the fade-out, Blend_StartFade/
 * Blend_StepFade the fade-in; WaitFrames busy-waits N frame-timer ticks
 * between steps. The middle do/while reseeds gIwram_5398 from
 * Input_Poll() until Credits_Tick reports completion (0xFE), and the
 * window registers (REG_WIN0H / REG_WIN1H at 0x04000040 / 0x04000044) are
 * cleared before the fade-in. The 0x03005398 base is anchored into a
 * local pointer so it survives across the loop's two BL callees. */

u8 Screen_FadeSequence(void)
{
    u16 *fadeState;

    Credits_Init(0);
    Credits_LoadBgGfx(0);
    Screen_BeginFlash(0xBF);
    while (Screen_TickFlash() != 0)
        WaitFrames(2);

    WaitFrames(0x78);
    IrisOpen(3, 20);
    Credits_LoadFrogGfx(0);
    Credits_InitScrollPage1(0);

    fadeState = (u16 *)0x03005398;
    do {
        *fadeState = Input_Poll();
    } while (Credits_Tick(0) != 0xFE);

    IrisClose(3, 20);
    *(vu16 *)0x04000040 = 0;
    *(vu16 *)0x04000044 = 0;
    WaitFrames(0x78);

    Blend_StartFade(0xBF);
    while (Blend_StepFade() != 0)
        WaitFrames(2);

    return 1;
}

/* Fade-in poll step (called from the do/while in Screen_FadeSequence). Mirrors the
 * room-state delay bookkeeping at 0x03006440 from Scene08_MapScreenTick: when the
 * delay counter (state[11]) has elapsed it steps Credits_ScrollTick and re-arms,
 * carrying that step's result out. Reports 0xFE once gIwram_5398 reaches 0x20,
 * which the caller's loop watches for. */
u8 Credits_Tick(u8 arg)
{
    u8 *state;
    u8 ret;

    ret = 1;
    state = (u8 *)0x03006440;
    if (*(u16 *)(state + 48) == 0) {
        state[11] = 8;
    }
    if (gGameStuff._unk00 - *(u32 *)(state + 4) >= state[11]) {
        ret = Credits_ScrollTick(arg);
        *(u32 *)(state + 4) = gGameStuff._unk00;
    }
    if (*(u16 *)0x03005398 == 32) {
        ret = 254;
    }
    return ret;
}

extern void Credits_DrawLine(const void *src, u32 dst, u8 arg2, u8 arg3);

u8 Credits_FillPage(u8 arg0, u8 arg1)
{
    u16 zero;
    u32 dst;
    u8 i;
    const u32 *table;
    u32 entry;
    u16 *zeroPtr;

    dst = (u32)arg1 * 0x800 + 0x2000000;
    /* zeroPtr anchors &zero into r1 before the zero-store, so r1 survives as
     * DMA3.src without a redundant reload: mov r1,sp / movs r0,#0 / strh r0,[r1]. */
    zeroPtr = &zero;
    zero = 0;
    REG_DMA3.src = zeroPtr;
    REG_DMA3.dst = (void *)dst;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;

    i = 0;
    table = (const u32 *)0x08308808;
    for (; i <= 15; i++) {
        entry = table[(u32)arg0 * 16 + i];
        if (entry == 0x081be2fc)
            goto exit_false;
        if (entry == 0)
            goto exit_false;
        Credits_DrawLine((const void *)entry, dst, 0, (u8)(i * 2));
    }
    return 1;
exit_false:
    return 0;
}
