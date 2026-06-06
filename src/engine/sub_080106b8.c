#include "macros.h"
#include "types.h"

/* Fade-in ticker. Decrements the fade countdown at 0x03006538; when
 * it reaches zero this frame, also clears the tick-RNG word at
 * 0x03005398 and the byte at 0x03003480+5. Then writes (16 -
 * countdown) to REG_BLDCNT so the blend fades up as the countdown
 * runs out. Returns the post-decrement countdown.
 *
 * Companion to Blend_StartFade (the fade-in init helper). 30 BL callers
 * across the ROM.
 *
 * Matching notes (old_agbcc, control-flow join would otherwise emit
 * push {lr}; pop {r1}; bx r1):
 *   - countdown pinned to r2 (otherwise allocated to r3).
 *   - p3480 anchors the 0x03003480 base before the [5] index so the
 *     constant fold doesn't collapse it to 0x03003485.
 *   - bldcnt pinned to r0 and the literal 16 pinned to r1 to force
 *     the target's evaluation order for `16 - *countdown`. */

u8 Blend_StepFade(void)
{
    register vu8 *countdown asm("r2") = (vu8 *)0x03006538;
    register vu16 *bldcnt asm("r0");
    vu8 *p3480 = (vu8 *)0x03003480;
    int c = *countdown;
    if (c != 0) {
        *countdown = c - 1;
        *(vu16 *)0x03005398 = 0;
        p3480[5] = 0;
    }
    bldcnt = (vu16 *)0x04000054;
    {
        register int n asm("r1") = 16;
        *bldcnt = n - *countdown;
    }
    return *countdown;
}

/* Fade-out init helper. Sets countdown=16, REG_BLDCNT=16 (full
 * darkness), and installs `arg` as REG_WININ. Companion to
 * Screen_TickFlash (fade-out ticker). */

u16 Screen_BeginFlash(u16 arg)
{
    *(vu8 *)0x03006538 = 16;
    *(vu16 *)0x04000054 = 16;
    *(vu16 *)0x04000050 = arg;
    return arg;
}

/* Fade-out ticker. Same countdown logic as Blend_StepFade but writes
 * the raw countdown value (rather than 16-countdown) to REG_BLDCNT,
 * so the blend darkens as the countdown runs out. 12 BL callers.
 *
 * Matching notes: same r2 pin + p3480 anchor as Blend_StepFade. The
 * final block doesn't need the bldcnt/n pins because there's no
 * arithmetic on countdown before the store. */

u8 Screen_TickFlash(void)
{
    vu8 *countdown = (vu8 *)0x03006538;
    vu8 *p3480 = (vu8 *)0x03003480;
    int c = *countdown;
    if (c != 0) {
        *countdown = c - 1;
        *(vu16 *)0x03005398 = 0;
        p3480[5] = 0;
    }
    *(vu16 *)0x04000054 = *countdown;
    return *countdown;
}

extern void FrogStatusBar_Update(void);

void Render_UpdateBlendRegs(void)
{
    FrogStatusBar_Update();

    if (*(vu8 *)0x03006500 == 1) {
        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0808;
        *(vu8 *)0x03006500 = 0;
    }
}

void Pal_RotateEntries(void)
{
    u32 *frameCounter = (u32 *)0x03005330;
    register u32 *state asm("r3") = (u32 *)0x03006540;
    u32 *savedFrameCounter;
    u32 *savedState;
    u16 value;
    u16 next;
    u8 i;
    u32 elapsed = *frameCounter - state[1];

    savedFrameCounter = frameCounter;
    savedState = state;

    if (elapsed <= 31) {
        return;
    }

    savedState[3] = 0x05000042;
    value = *(u16 *)0x05000042;

    for (i = 0; i <= 14; i++) {
        if (i <= 13) {
            u16 *cursor = (u16 *)state[3];
            next = cursor[1];
            state[3] = (u32)(cursor + 1);
            cursor[1] = value;
            value = next;
        } else {
            u16 *cursor = (u16 *)(state[3] - 28);
            state[3] = (u32)cursor;
            *cursor = next;
        }
    }

    savedState[1] = *savedFrameCounter;
}

u32 Render_DmaLoadTileset(u8 layer)
{
    vu32 *dma;
    u32 cnt;

    switch (layer) {
    case 0:
        dma = (vu32 *)0x040000D4;
        dma[0] = *(u32 *)0x08306918;
        dma[1] = 0x06008040;
        cnt = 0x80000420;
        break;
    case 1:
        dma = (vu32 *)0x040000D4;
        {
            u32 *sources = (u32 *)0x08306918;
            dma[0] = sources[1];
        }
        dma[1] = 0x06008880;
        /* Keep agbcc from tail-merging this case with case 2; emits no code. */
        asm("");
        cnt = 0x80000400;
        break;
    case 2:
        dma = (vu32 *)0x040000D4;
        {
            u32 *sources = (u32 *)0x08306918;
            dma[0] = sources[2];
        }
        dma[1] = 0x06009080;
        cnt = 0x80000400;
        break;
    case 3:
        dma = (vu32 *)0x040000D4;
        {
            u32 *sources = (u32 *)0x08306918;
            dma[0] = sources[3];
        }
        dma[1] = 0x06009880;
        cnt = 0x80000500;
        break;
    default:
        return layer;
    }

    dma[2] = cnt;
    return dma[2];
}

void *WrapBufPtr(void *ptr, void *base)
{
    u8 *pos = ptr;
    u8 *start = base;
    u8 *end = start + 0x800;

    if (pos >= end) {
        pos += -0x800;
        pos -= (u32)start;
        return start + (((s32)pos >> 1) << 1);
    }

    if (pos >= start) {
        return pos;
    }

    pos = start - (u32)pos;
    return end - (((s32)pos >> 1) << 1);
}

void Anim_AdvanceFrameStep(void)
{
    u32 *frameCounter = (u32 *)0x03005330;
    u8 *state = (u8 *)0x03006480;
    vu32 *dma;
    register u8 index asm("r5");
    u32 *table;
    register u32 offset asm("r0");

    if (*frameCounter - *(u32 *)(state + 4) <= 7)
        return;

    if (state[10] > 23)
        state[10] = 0;

    dma = (vu32 *)0x040000D4;
    table = (u32 *)0x083068A8;
    asm("" : "+r"(table));
    index = state[10];
    offset = index;
    offset <<= 2;
    dma[0] = *(u32 *)(offset + (u32)table);
    dma[1] = 0x06001C00;
    dma[2] = 0x80000090;
    (void)dma[2];

    state[10]++;
    *(u32 *)(state + 4) = *frameCounter;
}

void Anim_TickFrame(void)
{
    u32 *frameCounter = (u32 *)0x03005330;
    u8 *state = (u8 *)0x03006480;
    vu32 *dma;
    register u8 index asm("r5");
    u32 *table;
    register u32 offset asm("r0");

    if (*frameCounter - *(u32 *)(state + 4) > 7) {
        if (state[10] > 23)
            state[10] = 0;

        dma = (vu32 *)0x040000D4;
        table = (u32 *)0x083068A8;
        asm("" : "+r"(table));
        index = state[10];
        offset = index;
        offset <<= 2;
        dma[0] = *(u32 *)(offset + (u32)table);
        dma[1] = 0x06001C00;
        dma[2] = 0x80000090;
        (void)dma[2];

        state[10]++;
        *(u32 *)(state + 4) = *frameCounter;
    }

    FrogStatusBar_Update();
}
