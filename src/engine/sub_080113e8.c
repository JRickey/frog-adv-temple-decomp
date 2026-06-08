#include "gba/io.h"
#include "types.h"
#include "iwram.h"

extern int __modsi3(int num, int den);

u32 GenRandomTileMask(void)
{
    u8 deck[28];
    u32 i;
    u8 deckSize;
    u32 result;
    u8 r1;
    u32 r2;
    u8 idx;

    result = 0;
    deckSize = 25;
    i = 0;
    r1 = 0;
    r2 = 128 << 5;

    do {
        if (i == 12) {
            result |= r2;
        } else {
            u8 r0 = r1;

            r1 = (r0 + 1) & 0xFF;
            deck[r0] = i;
        }
        i = (u8)(i + 1);
    } while (i <= 24);

    deckSize = (deckSize - 1) & 0xFF;
    i = 0;

    do {
        u8 r0 = (u8)REG_VCOUNT;
        u8 *ptr;

        idx = __modsi3(r0 * 107 + 7, deckSize) & 0xFF;
        /* ptr anchors sp+idx before deckSize-- so agbcc emits the address
         * computation first, matching the baserom's instruction order. */
        ptr = deck + idx;
        deckSize = (deckSize - 1) & 0xFF;
        result |= (u32)(1 << *ptr);
        i++;

        if (idx < deckSize) {
            do {
                deck[idx] = deck[idx + 1];
                idx++;
            } while (idx < deckSize);
        }

        i = (u8)i;
    } while (i <= 3);

    return result;
}

void Tilemap_BlitTileRows(u32 flags, u32 dstX, u32 dstY, u32 widthArg, u32 srcRowsArg, void *srcTable, u32 srcIndex);

struct BlitRecord {
    u16 dstX;
    u16 dstY;
    u16 width;
    u16 rows;
    u8 flags;
    u8 _pad9[3];
    u8 delay;
    u8 _padD[3];
    const u16 **srcTable;
    u32 _pad14;
};

extern struct BlitRecord gBlitParamTable_08306b74[];
struct BlitSrcEntry {
    const u16 **srcTable;
    u32 _pad04;
    u8 _pad08[16];
};

extern struct BlitSrcEntry gBlitSrcTable_08306b84[];

void Blit_ApplyFlaggedRecords(u8 count, struct BlitRecord *records, u8 srcIndex)
{
    u32 limit;
    register u8 idx asm("sl") = srcIndex;
    register struct BlitRecord *romTable asm("r9");
    u8 i;
    u32 stride;

    i = 0;
    if (i >= (u8)count)
        return;

    romTable = gBlitParamTable_08306b74;
    do {
        if ((gIwram_6110.selector5Flags >> i) & 1) {
            struct BlitRecord *rec;

            stride = (u32)i * 24;
            rec = (struct BlitRecord *)(stride + (u32)records);
            Tilemap_BlitTileRows(rec->flags, rec->dstX, rec->dstY, rec->width, rec->rows, rec->srcTable, idx);
            if (i != 3) {
                struct BlitRecord *romRec = (struct BlitRecord *)(stride + (u32)romTable);
                struct BlitSrcEntry *srcBase = gBlitSrcTable_08306b84;

                Tilemap_BlitTileRows(romRec->flags, romRec->dstX, romRec->dstY, romRec->width, romRec->rows,
                                     srcBase[i].srcTable, 3);
            }
        }
        i = (u8)(i + 1);
    } while (i < (u8)count);
}

struct IwramAt6580_sub11518 {
    u8 _pad00[4];
    u32 lastTime;
    u8 _pad08[2];
    u8 field_a; /* +0x0a */
    u8 field_b; /* +0x0b */
};

extern u8 gIwram_3610;
extern u8 gIwram_53A0;
extern u8 gIwram_60A0[];
extern struct ScrollBlitLayer gIwram_6480;
extern struct ScrollBlitLayer gIwram_6540;
extern struct IwramAt6580_sub11518 gIwram_6580;
extern struct BlitRecord gBlitInitTable_08306AD4[];

void Selector_InitState(void)
{
    u8 *base = &gIwram_3610;
    struct ScrollBlitLayer *p6480;
    struct ScrollBlitLayer *p6540;
    u8 zero;
    /* zero=0 inline: agbcc emits movs r2,#0 after adds r0,#0xc8 */
    base[0xC8] = (zero = 0);
    gIwram_53A0 = zero;
    gIwram_60A0[0] = zero;
    p6540 = &gIwram_6540;
    p6540->_field_34 = zero;
    p6480 = &gIwram_6480;
    p6480->_field_36 = zero;
    p6540->frameCtr = 0;
    p6480->frameCtr = 0;
    p6540->phase = 0;
    p6480->phase = 2;
    gIwram_6580.field_b = 0x50;
    gIwram_6580.field_a = 3;
    Blit_ApplyFlaggedRecords(4, gBlitInitTable_08306AD4, 1);
}
