#include "gba/dma.h"
#include "iwram.h"
#include "types.h"

extern void sub_0801AA60(u8 arg);
extern u32 sub_08020C78(u32 sound);

void sub_0801AC84(u8 arg)
{
    u8 *state;
    u32 tableBase;
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

void sub_0801AD10(u8 a0)
{
    /* plain local for arg: agbcc allocates to r4 with 3-insn zero-extend
     * (adds r4,r0,#0; lsls r4,r4,#24; lsrs r4,r4,#24) rather than
     * the 2-insn form that register u8 arg asm("r4") = a0 would emit */
    u8 arg;
    u8 *state;
    register u8 b1 asm("r5");
    const u32 *const *entryPtr;
    const u32 *base;
    register u32 sum asm("r1");
    u8 byteZero;
    u16 halfZero;
    vu16 fill;
    vu32 *dma;

    arg = a0;
    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600F84C;
    *(u32 *)(state + 36) = 0x0600F84C + 0x80;

    {
        u32 tableBase = 0x080C1254;
        asm volatile("" : "+r"(tableBase));
        entryPtr = (const u32 *const *)(gIwram_34B0._data * 24 + tableBase);
    }

    {
        register const u8 *p asm("r1") = (const u8 *)0x03003540;
        u32 b2 = p[12];
        b1 = p[1];
        asm volatile("" : "+r"(p));
        sum = b2 + b1;
    }
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
    dma[1] = 0x0600FBC0;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)dma[2];

    sub_0801AA60(arg);
    {
        const u32 *tbl;
        u32 idx;
        /* barrier keeps tbl load before idx computation so agbcc emits
         * adds r4,#1; lsls r4,r4,#2 rather than folding +1 into the
         * pool address and using ldr r0,[r4,#4] */
        tbl = (const u32 *)0x081BDA70;
        asm volatile("" : "+r"(tbl));
        idx = (u32)arg + 1;
        sub_08020C78(tbl[idx]);
    }
}
