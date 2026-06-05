#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

/* Per-scene reset: blanks BG3, DMA3-clears the twelve 0x800-byte EWRAM scratch
 * banks (0x02000000..0x02005800) plus the OBJ-VRAM window at 0x0600F800, then
 * streams a per-scene source block (from a ROM table indexed by gIwram_34B0)
 * and two fixed ROM blocks into OBJ VRAM + palette RAM, and seeds palette slot
 * 0x050001E2. The DMA cnt for every clear is the shared 0x81000400
 * (DMA_ENABLE | DMA_SRC_FIXED | 0x400); the cleared-source halfword is a stack
 * local. Sibling of sub_0801D4CC / sub_0801D150 (same DMA-clear family, same
 * 0x080C1254 ROM table with a 24-byte stride keyed on gIwram_34B0._data).
 *
 * Matching notes (old_agbcc):
 *   - The first `zero = 0` is sequenced before `dma = &REG_DMA3` so the stack
 *     halfword store lands before the DMA-channel base is derived (the baserom
 *     reaches REG_DMA3 as a +0xC6 add off the BG3CNT pointer it already holds).
 *   - tableBase is kept opaque (input barrier) so its `+ 4` stays an `adds` on
 *     the single 0x080C1254 pool word instead of folding into a 0x080C1258
 *     constant or a `ldr [base, #4]` offset; rowOff materializes the 24x index
 *     scale first so the `adds #4` is emitted after the multiply, matching the
 *     baserom\'s order. */
void sub_0801D880(void)
{
    volatile DmaChannel *dma;
    const u32 *table;
    const void *objSrc;
    u32 tableBase;
    u32 rowOff;
    u16 zero;

    gIwram_34A0.dispatchIdx = 0;

    REG_DISPCNT = 0x800;
    REG_BG3CNT = 0x1F08;
    *(vu16 *)0x0400001C = 0;
    *(vu16 *)0x0400001E = 0;

    zero = 0;

    dma = &REG_DMA3;
    dma->src = &zero;
    dma->dst = (void *)0x02000000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02000800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02001000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02001800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02002000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02002800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02003000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02003800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02004000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02004800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02005000;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x02005800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    objSrc = (const void *)0x080E7AB6;
    tableBase = 0x080C1254;
    asm volatile("" ::"r"(tableBase));
    rowOff = gIwram_34B0._data * 24;
    tableBase += 4;
    table = *(const u32 *const *)(rowOff + tableBase);

    zero = 0;
    dma->src = &zero;
    dma->dst = (void *)0x0600F800;
    dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma->cnt;

    dma->src = table;
    dma->dst = (void *)0x06008000;
    dma->cnt = DMA_ENABLE | 0x2000;
    (void)dma->cnt;

    dma->src = objSrc;
    dma->dst = (void *)0x06008020;
    dma->cnt = DMA_ENABLE | 0x340;
    (void)dma->cnt;

    dma->src = (const void *)0x080E3774;
    dma->dst = (void *)0x050001C0;
    dma->cnt = DMA_ENABLE | 0x10;
    (void)dma->cnt;

    *(vu16 *)0x050001E2 = 0x37D;
}
