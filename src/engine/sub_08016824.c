#include "gfx.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "iwram.h"
#include "game.h"

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

void TileBlit_DrawEntry(u8 index)
{
    struct TileBlitRecord *tableBase;
    u32 stride;
    register struct TileBlitRecord *entry asm("r2");
    u16 *vramDst;
    const u16 *src;
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
        u32 srcAddr;

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
        struct TileBlitRecord *loopEntry;
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

/* Re-declare without prototype so Icon_DmaLoadSprite passes idx (u32 in r4) as-is via
 * `add r0, r4, #0` — no zero-extension of the u8 parameter — matching the baserom. */
void TileBlit_DrawEntry();

/* DMA descriptor table: 16-byte entries at 0x08306888. Each entry holds
 * (at byte offset 4) a pointer to a source pointer, (at +8) the destination
 * address, and (at +12) a byte count as a u16. */
extern u32 gDmaDescTable_08306888[];

void Icon_DmaLoadSprite(void)
{
    u32 idx;
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
        u32 tableBase = (u32)gDmaDescTable_08306888;
        register u32 r0r asm("r0");

        r1val = idx << 4;
        /* DMA source: double-deref the pointer stored at table[idx]+4.
         * REG_DMA3 base is loaded between the two derefs (agbcc scheduling). */
        r0r = tableBase + 4;
        r0r = r1val + r0r;
        r0r = *(u32 *)r0r;
        dma = (volatile u32 *)0x040000D4;
        r0r = *(u32 *)r0r;
        dma[0] = r0r;

        /* DMA destination: single-deref the u32 at table[idx]+8. */
        r0r = tableBase;
        r0r += 8;
        r0r = r1val + r0r;
        r0r = *(u32 *)r0r;
        dma[1] = r0r;

        /* DMA count: ldrh at table[idx]+12, shift right to get halfword count. */
        r1val += tableBase;
        r1val = *(u16 *)(r1val + 12);
        r0r = r1val >> 1;
        r1val = 0x80;
        r1val <<= 24; /* stride = 0x80000000 = DMA_ENABLE */
        r0r |= r1val;
        dma[2] = r0r;
        (void)dma[2];
    }

    /* Palette DMA: 16 colors (0x10 halfwords) from ROM to OBJ palette slot. */
    dma[0] = 0x08173038;
    dma[1] = 0x05000180;
    dma[2] = 0x80000010;
    (void)dma[2];

    TileBlit_DrawEntry(idx);
}

/* DMA descriptor table at 0x08306888 with richer entry layout:
 * +0: u16 maxCount, +2: u8 threshold, +4: ptr to ptr array,
 * +8: u32 destAddr, +12: u16 count */
void Icon_DmaUpdateSprite(void)
{
    /* ip holds the gGameStuff base across the whole function; used to
     * produce 'mov r1, ip; ldr r0, [r1, #0]' at the end. */
    u32 idx;
    register u32 gs asm("ip");
    volatile u32 *dma;

    {
        register u32 r1val asm("r1");
        u8 mode;

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
    }

    if (idx == 15)
        return;

    gs = (u32)&gGameStuff;

    {
        /* tableBase left unpinned so agbcc allocates it to r7 and includes
         * r7 in the push/pop (explicit asm(r7) pins bypass callee-save). */
        struct IwramAt5320 *s;
        struct DmaDesc2Entry *tableBase;
        struct DmaDesc2Entry *entry;
        u32 stride;
        u32 diff;

        s = &gIwram_5320;
        diff = *(u32 *)gs - s->field4;
        tableBase = (struct DmaDesc2Entry *)gDmaDescTable_08306888;
        stride = idx << 4;
        entry = (struct DmaDesc2Entry *)((u32)tableBase + stride);

        if (diff < entry->threshold)
            return;

        if (s->byte0 >= entry->maxCount)
            s->byte0 = 0;

        {
            /* r0 is the address register; r3 receives the loaded pointer.
             * Two-step "(r0 << 24) >> 22" prevents agbcc folding to "<< 2". */
            register u32 r0r asm("r0");
            u32 r3r;

            r0r = (u32)tableBase + 4;
            r0r = stride + r0r;
            r3r = *(u32 *)r0r;
            dma = (volatile u32 *)0x040000D4;
            r0r = s->byte0;
            s->byte0 = (u8)(r0r + 1);
            r0r <<= 24;
            r0r >>= 22;
            r0r = r0r + r3r;
            r0r = *(u32 *)r0r;
            dma[0] = r0r;

            r0r = (u32)tableBase;
            r0r += 8;
            r0r = stride + r0r;
            r0r = *(u32 *)r0r;
            dma[1] = r0r;

            {
                u32 r5r;
                r5r = entry->count;
                r0r = r5r >> 1;
            }
            r0r |= 0x80000000U;
            dma[2] = r0r;
            (void)dma[2];
        }

        {
            /* Must go through r1 to match "mov r1, ip; ldr r0, [r1, #0]". */
            register u32 r1r asm("r1");
            u32 r0r;
            r1r = gs;
            r0r = *(u32 *)r1r;
            s->field4 = r0r;
        }
    }
}
