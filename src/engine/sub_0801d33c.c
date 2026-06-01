#include "gba/dma.h"
#include "types.h"

#define sFrogObjPaletteSrc ((const void *const *)0x08308f3c)

extern const void *const gFrogTileSrcA_083087C8[];
extern const void *const gFrogPaletteSrcB_083087E8[];

void sub_0801D33C(u8 arg)
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
