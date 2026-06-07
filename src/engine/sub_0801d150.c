#include "gba/dma.h"
#include "sound.h"
#include "types.h"

extern void Credits_LoadBgGfx(u8 arg);
extern void Sound_DrainIfActive(void);

void Credits_Init(u8 arg)
{
    register u16 zeroReg asm("r4");
    volatile DmaChannel *dma;
    u8 *state;
    vu16 *regs;
    u16 *zeroPtr;
    u16 clear;
    u16 zero;

    zeroPtr = &zero;
    zeroReg = 0;
    *zeroPtr = zeroReg;
    dma = &REG_DMA3;
    dma->src = &zero;
    dma->dst = (void *)0x06000000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x2000;
    (void)dma->cnt;

    zero = zeroReg;
    dma->src = &zero;
    dma->dst = (void *)0x06008000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x2000;
    (void)dma->cnt;

    zero = zeroReg;
    dma->src = &zero;
    dma->dst = (void *)0x0600E000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = zeroReg;
    dma->src = &zero;
    dma->dst = (void *)0x0600F800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    *(vu16 *)0x04000040 = 0xF0;
    *(vu16 *)0x04000044 = 0x70A0;
    *(vu16 *)0x04000042 = 0xF0;
    *(vu16 *)0x04000046 = 0x30;
    *(vu16 *)0x04000048 = 0x0808;
    *(vu16 *)0x0400004A = 0x3F3F;
    *(vu16 *)0x0400004A ^= 8;

    *(vu16 *)0x04000000 = 0x900;
    *(vu16 *)0x04000008 = 0x1C83;
    *(vu16 *)0x0400000E = 0x1F08;

    regs = (vu16 *)0x03003550;
    clear = 0;
    regs[0] = clear;
    regs[1] = clear;
    regs[6] = clear;
    regs[7] = clear;
    regs = (vu16 *)0x04000010;
    *regs = clear;
    regs++;
    *regs = clear;
    regs += 5;
    *regs = clear;
    regs++;
    *regs = clear;

    Credits_LoadBgGfx(arg);
    state = (u8 *)0x03003540;
    state[1] = (u8)zeroReg;
    state[12] = (u8)zeroReg;
    Sound_DrainIfActive();
    Sound_PlayIfEnabled(0);
}
