#include "gfx.h"
#include "game.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "gba/syscall.h"
#include "iwram.h"

extern u16 gIwram_5398;
extern u8 gIwram_5330[];
extern const void *const sUiAssetSlots[];
extern u8 gIwram_3498[];

u32 GetFrameTick(void);
u16 Blend_StartFade(u16 arg);
s32 Screen_TickFlash(void);

void UiScreen_Init(void)
{
    struct IwramAt34A0 *dispatch;
    u16 *fadeState;
    register u32 zero asm("r5");
    struct IwramAt3480 *state;
    volatile DmaChannel *dma;

    fadeState = &gIwram_5398;
    zero = 0;
    *fadeState = zero;

    state = &gIwram_3480;
    state->subState = zero;
    state->menu25Step = zero;
    state->_unk01 = zero;
    state->menuStep = zero;
    state->blinkCounter = zero;
    state->routerSelection = zero;
    state->reloadFlag = zero;
    state->menu26Step = zero;

    dispatch = &gIwram_34A0;
    dispatch->dispatchIdx = zero;

    state->lastAdvanceTick = GetFrameTick();
    Screen_BeginFlash(0xBF);

    *(vu16 *)0x0400000E = 0x1E88;

    LZ77UnCompVramAndGetSize(sUiAssetSlots[0], (void *)0x06008000);

    dma = &REG_DMA3;
    dma->src = sUiAssetSlots[1];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    dma->src = sUiAssetSlots[2];
    dma->dst = (void *)0x0600F000;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    REG_DISPCNT = DISPCNT_OBJ_1D | DISPCNT_BG3_ON;

    state->subState++;
    dispatch->_field_00 = zero;
}

void sub_08017B68(void)
{
    struct IwramAt3480 *state;
    u8 *game;
    u32 zero;

    state = &gIwram_3480;
    zero = 0;
    state->routerSelection = zero;
    game = gIwram_5330;
    game += 0x24;
    *game = zero;

    if (Screen_TickFlash() != 0) {
        return;
    }

    if (GetFrameTick() - state->lastAdvanceTick <= 119) {
        return;
    }

    gIwram_34A0.dispatchIdx = 1;
    state->subState++;
    state->lastAdvanceTick = GetFrameTick();
    Blend_StartFade(0xBF);

    gIwram_3470[0] = zero;
    gIwram_3470[1] = zero;
    gIwram_3470[2] = 0xF0;
    gIwram_3470[3] = 0xA0;

    gIwram_3478[0] = zero;
    gIwram_3478[1] = zero;
    gIwram_3478[2] = 0x58;
    gIwram_3478[3] = 0x10;

    gIwram_3474[0] = zero;
    gIwram_3474[1] = zero;
    gIwram_3474[2] = 0xA0;
    gIwram_3474[3] = 0x50;

    gIwram_3498[0] = zero;
    gIwram_3498[1] = zero;
    gIwram_3498[2] = 0x72;
    gIwram_3498[3] = 9;
}
