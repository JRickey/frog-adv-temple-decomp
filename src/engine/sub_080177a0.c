#include "macros.h"
#include "types.h"

extern int SaveReadBlocks(u16 *buf, u32 start, u32 count);
extern int SaveWriteBlocks(u16 *buf, u32 start, u32 count);
extern u32 sub_08033A70(u32 index, u16 *buf);
extern u32 sub_08033B28(u32 index, u16 *buf);
extern u32 sub_08033C0C(u32 index, u16 *buf);

int SaveReadHeader(u16 *dest)
{
    u16 buf[4];
    u8 i;

    if (SaveReadBlocks(buf, 0, 1)) {
        i = 0;
        do {
            dest[i] = buf[i];
            i++;
        } while (i <= 3);
        return 1;
    }
    return 0;
}

int SaveWriteHeader(u16 *src)
{
    u16 buf[4];
    u8 i;

    i = 0;
    do {
        buf[i] = src[i];
        i++;
    } while (i <= 3);

    if (SaveWriteBlocks(buf, 0, 1)) {
        return 1;
    }
    return 0;
}

int SaveReadSlot(u16 *dest, u8 idx)
{
    u16 buf[8];
    u8 i;

    if (SaveReadBlocks(buf, idx * 3 + 1, 2)) {
        i = 0;
        do {
            dest[i] = buf[i];
            i++;
        } while (i <= 7);
        return 1;
    }
    return 0;
}

int SaveWriteSlot(u16 *src, u32 idx)
{
    volatile u16 *srcp;
    u32 ridx;
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

    if (SaveWriteBlocks(buf, start, 2)) {
        return 1;
    }
    return 0;
}

int SaveWriteBlocks(u16 *buf, u32 start, u32 count)
{
    u32 start16;
    u32 count8;
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

int SaveReadBlocks(u16 *buf, u32 start, u32 count)
{
    u32 start16;
    u32 count8;
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
        if ((sub_08033A70((u16)(start16 + i), buf + i * 4) << 16) != 0)
            goto fail;
        i++;
    }

    return 1;

fail:
    return 0;
}

void sub_08017938(void)
{}
