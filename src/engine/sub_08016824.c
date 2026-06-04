#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "iwram.h"

struct TileBlitRecord {
    u16 colStart;
    u16 tileRow;
    u16 colCount;
    u16 rowCount;
    u8 _pad8[8];
    const u16 **srcTable;
    u32 _pad20;
};

extern struct TileBlitRecord gTileBlitTable_08306840[];

void sub_08016824(u8 index)
{
    register struct TileBlitRecord *tableBase asm("r5");
    u32 stride;
    register struct TileBlitRecord *entry asm("r2");
    register u16 *vramDst asm("r1");
    register const u16 *src asm("r4");
    u32 row;

    tableBase = gTileBlitTable_08306840;
    stride = ((u32)index * 2 + (u32)index) << 3;
    entry = (struct TileBlitRecord *)(stride + (u32)tableBase);
    vramDst = (u16 *)((u32)entry->colStart * 2);
    {
        u32 rowOffset;

        rowOffset = (u32)entry->tileRow << 6;
        rowOffset += 0x0600f800;
        vramDst = (u16 *)((u32)vramDst + rowOffset);
    }
    {
        register u32 srcAddr asm("r0");

        srcAddr = (u32)tableBase;
        srcAddr += 16;
        srcAddr = stride + srcAddr;
        src = **(const u16 ***)srcAddr;
    }

    row = 0;
    if (row >= entry->rowCount)
        return;

    {
        register struct TileBlitRecord *loopBase asm("ip");
        register struct TileBlitRecord *loopEntry asm("r5");
        u32 loopStride;

        loopBase = tableBase;
        loopEntry = entry;
        loopStride = stride;

        do {
            register struct TileBlitRecord *p asm("r3");
            u8 col;
            u32 nextRow;

            col = 0;
            nextRow = row + 1;
            if (col < loopEntry->colCount) {
                p = (struct TileBlitRecord *)(loopStride + (u32)loopBase);
                do {
                    *vramDst++ = *src++;
                    col = (u8)(col + 1);
                } while (col < p->colCount);
            }
            vramDst += (32 - loopEntry->colCount);
            row = (u8)nextRow;
        } while ((u8)row < loopEntry->rowCount);
    }
}

/* Re-declare without prototype so sub_080168A0 passes idx (u32 in r4) as-is via
 * `add r0, r4, #0` — no zero-extension of the u8 parameter — matching the baserom. */
void sub_08016824();

/* DMA descriptor table: 16-byte entries at 0x08306888. Each entry holds
 * (at byte offset 4) a pointer to a source pointer, (at +8) the destination
 * address, and (at +12) a byte count as a u16. */
extern u32 gDmaDescTable_08306888[];

void sub_080168A0(void)
{
    register u32 idx asm("r4");
    u8 mode;
    register u32 r1val asm("r1");
    volatile u32 *dma;

    r1val = 15;
    mode = gIwram_6110.threshold;
    if (mode == 3)
        goto case3;
    if (mode == 5)
        goto case5;
    goto cont;
case3:
    r1val = 0;
    goto cont;
case5:
    r1val = 1;
cont:
    idx = r1val;

    if (idx == 15)
        return;

    gIwram_5320.byte0 = 0;

    {
        register u32 tableBase asm("r3") = (u32)gDmaDescTable_08306888;
        register u32 stride asm("r1") = idx << 4;
        register u32 r0r asm("r0");

        /* DMA source: double-deref the pointer stored at table[idx]+4.
         * REG_DMA3 base is loaded between the two derefs (agbcc scheduling). */
        r0r = tableBase + 4;
        r0r = stride + r0r;
        r0r = *(u32 *)r0r;
        dma = (volatile u32 *)0x040000D4;
        r0r = *(u32 *)r0r;
        dma[0] = r0r;

        /* DMA destination: single-deref the u32 at table[idx]+8. */
        r0r = tableBase;
        r0r += 8;
        r0r = stride + r0r;
        r0r = *(u32 *)r0r;
        dma[1] = r0r;

        /* DMA count: ldrh at table[idx]+12, shift right to get halfword count. */
        stride += tableBase;
        stride = *(u16 *)(stride + 12);
        r0r = stride >> 1;
        stride = 0x80;
        stride <<= 24; /* stride = 0x80000000 = DMA_ENABLE */
        r0r |= stride;
        dma[2] = r0r;
        (void)dma[2];
    }

    /* Palette DMA: 16 colors (0x10 halfwords) from ROM to OBJ palette slot. */
    dma[0] = 0x08173038;
    dma[1] = 0x05000180;
    dma[2] = 0x80000010;
    (void)dma[2];

    sub_08016824(idx);
}
