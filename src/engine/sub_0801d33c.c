#include "gba/dma.h"
#include "iwram.h"
#include "types.h"

#define sFrogObjPaletteSrc ((const void *const *)0x08308f3c)

extern const void *const gFrogTileSrcA_083087C8[];
extern const void *const gFrogPaletteSrcB_083087E8[];

void Credits_LoadFrogGfx(u8 arg)
{
    const u8 *srcB;
    const u8 *srcA;
    const void *const *tableA;
    u32 idx;

    srcB = (const u8 *)0x081be074;
    srcA = (const u8 *)0x081be054;

    REG_DMA3.src = sFrogObjPaletteSrc[0];
    REG_DMA3.dst = (void *)0x050001c0;
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = srcA;
    REG_DMA3.dst = (void *)0x0600fbf4;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = srcA + 8;
    REG_DMA3.dst = (void *)0x0600fc34;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = srcA + 16;
    REG_DMA3.dst = (void *)0x0600fc74;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;

    srcA += 24;
    REG_DMA3.src = srcA;
    REG_DMA3.dst = (void *)0x0600fcb4;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;

    tableA = gFrogTileSrcA_083087C8;
    idx = arg + 1;
    REG_DMA3.src = tableA[idx];
    REG_DMA3.dst = (void *)0x06008020;
    REG_DMA3.cnt = DMA_ENABLE | 0x100;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = gFrogPaletteSrcB_083087E8[idx];
    REG_DMA3.dst = (void *)0x050001e0;
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = srcB;
    REG_DMA3.dst = (void *)0x0600f841;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = srcB + 8;
    REG_DMA3.dst = (void *)0x0600f881;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = srcB + 16;
    REG_DMA3.dst = (void *)0x0600f8c1;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = srcB + 24;
    REG_DMA3.dst = (void *)0x0600f901;
    REG_DMA3.cnt = DMA_ENABLE | 0x4;
    (void)REG_DMA3.cnt;
}

extern void Sound_DrainActiveSlots(void);
extern void Sound_Play(u32 a);

void Credits_InitScrollPage2(u8 arg)
{
    u8 *state;
    u32 tableBase;
    const u32 *const *entry;
    const u32 *base;
    u16 zero;
    vu16 fill;

    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600FBC2;
    *(u32 *)(state + 36) = 0x0600FBC2 + 0x80;

    tableBase = 0x080C1254;
    asm volatile("" ::"r"(tableBase));
    entry = (const u32 *const *)(gIwram_34B0._data * 24 + tableBase);
    base = entry[0];
    *(u32 *)(state + 12) = *(const u32 *)((const u8 *)base + arg * 4 + 0x9C);

    {
        u8 byteZero = 0;
        u16 halfZero = 0;
        asm volatile("" : "+r"(byteZero), "+r"(halfZero));
        state[8] = byteZero;
        zero = halfZero;
    }
    *(u16 *)(state + 44) = zero;
    *(u16 *)(state + 48) = zero;
    *(u16 *)(state + 50) = zero;
    state[11] = 8;

    fill = zero;
    REG_DMA3.src = (const void *)&fill;
    REG_DMA3.dst = (void *)0x0600FBC0;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)REG_DMA3.cnt;

    fill = zero;
    REG_DMA3.src = (const void *)&fill;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)REG_DMA3.cnt;

    Credits_LoadFrogGfx(arg);
    Sound_DrainActiveSlots();
    Sound_Play(0x4B);
}
