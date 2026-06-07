#include "gfx.h"
#include "macros.h"
#include "types.h"

extern const struct ScaleAnimDesc sScaleAnimDescriptors[];

void ScaleAnim_BlitDescIdx0(u8 idx)
{
    const u8 *base = (const u8 *)sScaleAnimDescriptors;
    u32 offset;
    const struct ScaleAnimDesc *desc;
    const u16 ***srcTableArr;

    offset = (u32)idx * 3;
    offset <<= 3;
    desc = (const struct ScaleAnimDesc *)(offset + (u32)base);

    sub_08012BC4(desc->flags, desc->dstX, desc->dstY, desc->width, desc->rows,
                 (srcTableArr = (const u16 ***)(offset + (u32)(base += 16)), *srcTableArr), 0);
}
