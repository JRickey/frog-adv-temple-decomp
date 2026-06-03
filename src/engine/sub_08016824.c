#include "macros.h"
#include "types.h"

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
