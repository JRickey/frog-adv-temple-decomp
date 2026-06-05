#include "types.h"

extern void sub_080340D4(u32 *in, u32 *out);
extern s32 sub_0803457C(u32 *a, u32 *b);

s32 sub_08034760(u32 a, u32 b)
{
    u32 buf0[4];
    u32 buf1[4];
    u32 valA = a;
    u32 valB = b;
    u32 f0;
    u32 f1;

    sub_080340D4(&valA, buf0);
    sub_080340D4(&valB, buf1);

    f0 = 0;
    if (buf0[0] <= 1)
        f0 = 1;
    if (f0 != 0)
        return -1;
    f1 = 0;
    if (buf1[0] <= 1)
        f1 = 1;
    if (f1 == 0)
        return sub_0803457C(buf0, buf1);
    return -1;
}
