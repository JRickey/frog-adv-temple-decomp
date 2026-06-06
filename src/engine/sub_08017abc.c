#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"

extern u16 gIwram_5398;
extern const void *const sUiAssetSlots[];

u32 GetFrameTick(void);
u16 Screen_BeginFlash(u16 arg);
void sub_0802D56C(const void *src, void *dst);

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
    state->_data[0] = zero;
    state->_data[3] = zero;
    state->_data[1] = zero;
    state->_data[2] = zero;
    state->_data[7] = zero;
    state->_data[5] = zero;
    state->_data[6] = zero;
    state->_data[4] = zero;

    dispatch = &gIwram_34A0;
    dispatch->dispatchIdx = zero;

    state->_unk0C = GetFrameTick();
    Screen_BeginFlash(0xBF);

    *(vu16 *)0x0400000E = 0x1E88;

    sub_0802D56C(sUiAssetSlots[0], (void *)0x06008000);

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

    state->_data[0]++;
    dispatch->_pad00 = zero;
}
