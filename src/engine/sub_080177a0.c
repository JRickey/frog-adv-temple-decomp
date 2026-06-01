#include "macros.h"
#include "types.h"

extern int sub_080178FC(u16 *buf, u16 start, u8 count);
extern int sub_0801789C(u16 *buf, u32 start, u32 count);
extern u32 sub_08033B28(u32 index, u16 *buf);
extern u32 sub_08033C0C(u32 index, u16 *buf);

int sub_080177A0(u16 *dest)
{
    u16 buf[4];
    u8 i;

    if (sub_080178FC(buf, 0, 1)) {
        i = 0;
        do {
            dest[i] = buf[i];
            i++;
        } while (i <= 3);
        return 1;
    }
    return 0;
}

int sub_080177D8(u16 *src)
{
    u16 buf[4];
    u8 i;

    i = 0;
    do {
        buf[i] = src[i];
        i++;
    } while (i <= 3);

    if (sub_0801789C(buf, 0, 1)) {
        return 1;
    }
    return 0;
}

int sub_08017814(u16 *dest, u8 idx)
{
    u16 buf[8];
    u8 i;

    if (sub_080178FC(buf, idx * 3 + 1, 2)) {
        i = 0;
        do {
            dest[i] = buf[i];
            i++;
        } while (i <= 7);
        return 1;
    }
    return 0;
}

int sub_08017858(u16 *src, u32 idx)
{
    register volatile u16 *srcp asm("r3");
    register u32 ridx asm("r1");
    u32 start;
    u16 buf[8];
    u8 i;

    srcp = src;
    asm("" : "+r"(srcp));
    ridx = idx;
    ridx <<= 24;
    ridx >>= 24;
    start = ridx * 3 + 1;
    i = 0;
    do {
        buf[i] = srcp[i];
        i++;
    } while (i <= 7);

    if (sub_0801789C(buf, start, 2)) {
        return 1;
    }
    return 0;
}

int sub_0801789C(u16 *buf, u32 start, u32 count)
{
    register u32 start16 asm("r6");
    register u32 count8 asm("r5");
    register u32 countShift asm("r2");
    u8 i;

    start <<= 16;
    start16 = start >> 16;
    asm("" : "+r"(start16));
    countShift = count;
    countShift <<= 24;
    asm("" : "+r"(countShift));
    count8 = countShift;
    count8 >>= 24;
    i = 0;
    while (i < count8) {
        if ((sub_08033B28((u16)(start16 + i), buf + i * 4) << 16) != 0)
            goto fail;
        i++;
    }

    i = 0;
    while (i < count8) {
        if ((sub_08033C0C((u16)(start16 + i), buf + i * 4) << 16) != 0)
            goto fail;
        i++;
    }

    return 1;

fail:
    return 0;
}
