#include "types.h"

extern void sub_0802EA2C(s16 a, u8 b, u32 c);

u32 sub_080316DC(u32 arg0, u8 **cursor)
{
    u8 *ptr = *cursor;

    sub_0802EA2C(*(s16 *)(ptr + 2), ptr[1], arg0);
    *cursor += 4;
    return 1;
}
