#include "macros.h"
#include "types.h"

extern int sub_080178FC(u16 *buf, u16 start, u8 count);
extern int sub_0801789C(u16 *buf, u16 start, u8 count);

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
