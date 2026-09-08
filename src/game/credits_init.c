#include "credits.h"
#include "gba/dma.h"
#include "iwram.h"
#include "sound.h"
#include "types.h"

/* Two ROM source-pointer pairs ({A,B} words each). */
#define gFrogTileSrcA ((const void *const *)0x083087c8)
#define gFrogTileSrcB ((const void *const *)0x083087e8)

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

/* Streams a fixed set of frog/sprite tile and palette blocks to VRAM and OBJ
 * palette RAM via DMA3. The character body tiles come from the 0x080C1254 ROM
 * table (24-byte stride) indexed by gIwram_34B0._data — same table/idx as the
 * sibling Credits_InitScrollPage1. Each transfer reads back REG_DMA3.cnt to flush the
 * write before the next channel setup.
 *
 * Matching: an input barrier on tableBase makes 0x080C1254 load first as an
 * opaque value, so the +4 stays a runtime `adds` on the base register instead
 * of folding into the load offset (mirrors the sibling Credits_InitScrollPage1). */
void Credits_LoadBgGfx(u8 arg)
{
    u32 tableBase;
    const u32 *const *entry;
    const void *src;
    const void *const *a;
    const void *const *b;

    tableBase = 0x080C1254;
    asm volatile("" : : "r"(tableBase));
    entry = (const u32 *const *)(gIwram_34B0._data * 24 + 4 + tableBase);
    src = (const void *)entry[0];

    REG_DMA3.src = (const void *)0x081fc758;
    REG_DMA3.dst = (void *)0x06000000;
    REG_DMA3.cnt = DMA_ENABLE | 0x4000;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = (const void *)0x081fbd58;
    REG_DMA3.dst = (void *)0x05000000;
    REG_DMA3.cnt = DMA_ENABLE | 0x100;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = (const void *)0x081fbf58;
    REG_DMA3.dst = (void *)0x0600e000;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = src;
    REG_DMA3.dst = (void *)0x06008000;
    REG_DMA3.cnt = DMA_ENABLE | 0x2000;
    (void)REG_DMA3.cnt;

    a = gFrogTileSrcA;
    REG_DMA3.src = a[1];
    REG_DMA3.dst = (void *)0x06008020;
    REG_DMA3.cnt = DMA_ENABLE | 0x100;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = a[0];
    REG_DMA3.dst = (void *)0x06008220;
    REG_DMA3.cnt = DMA_ENABLE | 0x100;
    (void)REG_DMA3.cnt;

    b = gFrogTileSrcB;
    REG_DMA3.src = b[0];
    REG_DMA3.dst = (void *)0x050001c0;
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;

    REG_DMA3.src = b[1];
    REG_DMA3.dst = (void *)0x050001e0;
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;
}
