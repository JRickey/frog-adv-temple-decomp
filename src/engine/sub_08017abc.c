#include "gfx.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "gba/syscall.h"
#include "iwram.h"

extern u16 gIwram_5398;
extern const void *const sUiAssetSlots[];

u32 GetFrameTick(void);

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
