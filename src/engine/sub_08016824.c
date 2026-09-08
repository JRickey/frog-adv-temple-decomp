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

/* `table` puts the pool load before the index shift; the srcPtrTable/destAddr
 * reads stay symbol-form so cse rewrites them through the live base
 * (adds r0, r7, #4) instead of folding into [r5, #n]. */
void Icon_DmaUpdateSprite(void)
{
    u32 idx;
    u32 elapsed;
    const struct DmaDesc2Entry *table;
    const struct DmaDesc2Entry *entry;
    const u32 *srcTable;

    idx = Icon_SelectSet();
    if (idx == ICON_SET_NONE)
        return;

    elapsed = ((GameStuff *)&gIwram_5330)->_unk00 - gIwram_5320.field4;
    table = gDmaDescTable_08306888;
    entry = &table[idx];
    if (elapsed < entry->threshold)
        return;

    if (gIwram_5320.byte0 >= entry->maxCount)
        gIwram_5320.byte0 = 0;

    srcTable = gDmaDescTable_08306888[idx].srcPtrTable;
    REG_DMA3.src = (const void *)srcTable[gIwram_5320.byte0++];
    REG_DMA3.dst = (void *)gDmaDescTable_08306888[idx].destAddr;
    REG_DMA3.cnt = DMA_ENABLE | (entry->count >> 1);
    (void)REG_DMA3.cnt;

    gIwram_5320.field4 = ((GameStuff *)&gIwram_5330)->_unk00;
}
