#include "types.h"

u32 sub_08031748(u32 arg0, u8 **cursor)
{
    u8 *ptr = *cursor;
    u32 offset;

    offset = *(u16 *)(ptr + 4);
    offset <<= 16;
    offset |= *(u16 *)(ptr + 2);
    *cursor = ptr + offset;
    return 1;
}
