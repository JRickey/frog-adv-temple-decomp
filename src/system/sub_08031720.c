#include "types.h"

extern void sub_0802EB34(u32 a, s16 b, u16 c, u32 d);

u32 sub_08031720(u32 arg0, u8 **cursor)
{
    u8 *ptr = *cursor;

    sub_0802EB34(ptr[1] & 1, *(s16 *)(ptr + 2), *(u16 *)(ptr + 4), arg0);
    *cursor += 6;
    return 1;
}
