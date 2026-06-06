#include "types.h"

extern void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel);

u32 sub_08031798(u32 arg0, u8 **cursor)
{
    u8 *ptr = *cursor;
    u32 offset;

    offset = *(u16 *)(ptr + 4);
    offset <<= 16;
    offset |= *(u16 *)(ptr + 2);
    cursor[1] = ptr + offset;
    *cursor = ptr + 6;
    return 1;
}

u32 sub_080317B0(u32 arg0, u8 **cursor)
{
    cursor[1] = 0;
    *cursor += 2;
    return 1;
}

u32 sub_080317C0(u32 arg0, u8 **cursor)
{
    sub_0802EF7C((*cursor)[1], *(u16 *)(*cursor + 2), (s32)arg0);
    *cursor += 4;
    return 1;
}
