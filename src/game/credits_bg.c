#include "gba/dma.h"
#include "credits.h"
#include "iwram.h"
#include "types.h"

/* Two ROM source-pointer pairs ({A,B} words each). */
#define gFrogTileSrcA ((const void *const *)0x083087c8)
#define gFrogTileSrcB ((const void *const *)0x083087e8)

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
    asm volatile("" ::"r"(tableBase));
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
