#include "macros.h"
#include "types.h"

struct ScaleAnimDesc {
    u16 dstX;
    u16 dstY;
    u16 width;
    u16 rows;
    u8 flags;
    u8 _pad09[7];
    const u16 **srcTable;
    u32 _pad20;
};

extern const struct ScaleAnimDesc sScaleAnimDescriptors[];

void sub_08012BC4(u32 flags, u32 dstX, u32 dstY, u32 widthArg, u32 srcRowsArg, const u16 **srcTable, u32 srcIndex);

void sub_08013980(u8 idx)
{
    register const u8 *base asm("r6") = (const u8 *)sScaleAnimDescriptors;
    register u32 offset asm("r5");
    register const struct ScaleAnimDesc *desc asm("r4");
    register const u16 ***srcTableArr asm("r5");

    offset = (u32)idx * 3;
    offset <<= 3;
    desc = (const struct ScaleAnimDesc *)(offset + (u32)base);

    sub_08012BC4(desc->flags, desc->dstX, desc->dstY, desc->width, desc->rows,
                 (srcTableArr = (const u16 ***)(offset + (u32)(base += 16)), *srcTableArr), 0);
}
