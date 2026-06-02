#include "gba/dma.h"
#include "iwram.h"
#include "types.h"

extern void sub_0801AA60(u8 arg);
extern u32 sub_08020C78(u32 sound);

void sub_0801AC84(u8 arg)
{
    register u8 *state asm("r3");
    register u32 tableBase asm("r4");
    register u8 b1 asm("r5");
    const u32 *const *entryPtr;
    const u32 *base;
    register u32 sum asm("r2");
    u8 byteZero;
    u16 halfZero;
    vu16 fill;
    vu32 *dma;

    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600FBC2;
    *(u32 *)(state + 36) = 0x0600FBC2 + 0x80;

    tableBase = 0x080C1254;
    asm volatile("" : "+r"(tableBase));
    entryPtr = (const u32 *const *)(gIwram_34B0._data * 24 + tableBase);

    {
        register const u8 *p asm("r2") = (const u8 *)0x03003540;
        tableBase = p[12];
        b1 = p[1];
        asm volatile("" : "+r"(p));
    }
    sum = tableBase + b1;
    base = entryPtr[0];
    sum = (sum << 2) + (u32)base;
    *(u32 *)(state + 12) = *(const u32 *)(sum + 0x38);

    byteZero = 0;
    halfZero = 0;
    asm volatile("" : "+r"(byteZero), "+r"(halfZero));
    state[8] = byteZero;
    *(u16 *)(state + 44) = halfZero;
    *(u16 *)(state + 48) = halfZero;
    *(u16 *)(state + 50) = halfZero;
    state[11] = 8;

    fill = halfZero;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&fill;
    dma[1] = 0x0600F800;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)dma[2];

    sub_0801AA60(arg);
    sub_08020C78(*(const u32 *)0x081BDA70);
}
