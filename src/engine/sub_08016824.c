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

enum IconSet {
    ICON_SET_3_ELEMENTS = 0,
    ICON_SET_5_ELEMENTS = 1,
    ICON_SET_NONE = 15,
};

#define TILEBLIT_SCREEN ((u16 *)0x0600f800)
#define ICON_PAL_RAM    ((void *)0x05000180)

extern struct TileBlitRecord gTileBlitTable_08306840[];
extern struct DmaDesc2Entry gDmaDescTable_08306888[];
extern const u16 sIconPalette_173038[];
extern u8 gIwram_5330;

/* Every record access goes through the symbol (no entry pointer local): the
 * loops re-derive &table[index], which gcse PRE turns into the ip/r5/r7
 * preheader copies. Grouping the screen constant with colStart keeps fold
 * from re-associating the destination sum. */
void TileBlit_DrawEntry(u8 index)
{
    u16 *dst;
    const u16 *src;
    u8 row;
    u8 col;

    dst = TILEBLIT_SCREEN + gTileBlitTable_08306840[index].colStart + gTileBlitTable_08306840[index].tileRow * 32;
    src = *gTileBlitTable_08306840[index].srcTable;
    for (row = 0; row < gTileBlitTable_08306840[index].rowCount; row++) {
        for (col = 0; col < gTileBlitTable_08306840[index].colCount; col++)
            *dst++ = *src++;
        dst += 32 - gTileBlitTable_08306840[index].colCount;
    }
}

/* Returns u8 so the inlined result is copied into the caller's u32 idx
 * (adds r4, r1, #0) instead of being expanded straight into it. */
static inline u8 Icon_SelectSet(void)
{
    u8 set;

    set = ICON_SET_NONE;
    switch (gIwram_6110.threshold) {
    case 3:
        set = ICON_SET_3_ELEMENTS;
        break;
    case 5:
        set = ICON_SET_5_ELEMENTS;
        break;
    }
    return set;
}

void Icon_DmaLoadSprite(void)
{
    u32 idx;
    const u32 *srcTable;

    idx = Icon_SelectSet();
    if (idx == ICON_SET_NONE)
        return;

    gIwram_5320.byte0 = 0;

    srcTable = gDmaDescTable_08306888[idx].srcPtrTable;
    REG_DMA3.src = (const void *)*srcTable;
    REG_DMA3.dst = (void *)gDmaDescTable_08306888[idx].destAddr;
    REG_DMA3.cnt = DMA_ENABLE | (gDmaDescTable_08306888[idx].count >> 1);
    (void)REG_DMA3.cnt;

    REG_DMA3.src = sIconPalette_173038;
    REG_DMA3.dst = ICON_PAL_RAM;
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;

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
