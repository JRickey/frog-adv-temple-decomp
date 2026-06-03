#include "game.h"
#include "types.h"

void sub_08012BC4(u32 flags, u32 dstX, u32 dstY, u32 widthArg, u32 srcRowsArg, const u16 **srcTable, u32 srcIndex);

struct BlitRecord_sub11574 {
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

struct IwramAt6580_sub11574 {
    u8 _pad00[4];
    u32 lastTime;
    u8 _pad08[2];
    u8 field_a;
    u8 field_b;
};

extern struct IwramAt6580_sub11574 gIwram_6580;
extern struct BlitRecord_sub11574 gBlitParamTable_08306b74[];

u32 sub_08011574(u8 idx)
{
    register struct BlitRecord_sub11574 *base asm("r8");
    register GameStuff *gs asm("r9");
    register struct IwramAt6580_sub11574 *s asm("r5");
    register u32 idxCopy asm("r1");
    register u32 stride asm("r6");
    register u32 strideTmp asm("r0");
    struct BlitRecord_sub11574 *entry;
    u32 fieldA;
    register u32 ipField asm("ip");
    u32 srcAddr;
    register u32 srcAddr2 asm("r4");
    const u16 **srcTable;
    GameStuff *p;

    idxCopy = idx;
    s = &gIwram_6580;
    fieldA = s->field_a;
    ipField = fieldA;
    if (ipField > 3)
        return 1;

    base = gBlitParamTable_08306b74;
    strideTmp = idxCopy << 1;
    strideTmp += idxCopy;
    stride = strideTmp << 3;
    entry = (struct BlitRecord_sub11574 *)(stride + (u32)base);
    s->field_b = entry->delay;

    p = &gGameStuff;
    gs = p;
    if (p->_unk00 - s->lastTime < s->field_b)
        return 0;

    sub_08012BC4(entry->flags, entry->dstX, entry->dstY, entry->width, entry->rows,
                 (srcAddr = (u32)base + 16, srcAddr2 = stride + srcAddr, srcTable = *(const u16 ***)srcAddr2, srcTable),
                 (s->field_a = (u8)(fieldA + 1), ipField));
    {
        register GameStuff *postGs asm("r1");

        postGs = gs;
        s->lastTime = postGs->_unk00;
    }
    return 0;
}
