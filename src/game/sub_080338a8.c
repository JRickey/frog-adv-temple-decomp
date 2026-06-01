#include "iwram.h"
#include "types.h"

#define gUnknown_030065E4 (*(const void **)0x030065e4)
#define sUnknown_082F8E98 ((const void *)0x082f8e98)
#define sUnknown_082F8EA4 ((const void *)0x082f8ea4)

u32 sub_080338A8(u32 value)
{
    u32 ret;

    value = (u16)value;
    ret = 0;
    if (value == 4) {
        gUnknown_030065E4 = sUnknown_082F8E98;
    } else if (value == 0x40) {
        gUnknown_030065E4 = sUnknown_082F8EA4;
    } else {
        gUnknown_030065E4 = sUnknown_082F8E98;
        ret = 1;
    }

    return ret;
}

void sub_080338EC(void)
{
    u32 timer;

    if (gIwram_3432 == 0) {
        return;
    }

    timer = gIwram_3432 - 1;
    gIwram_3432 = timer;
    if ((u16)timer == 0) {
        gIwram_3434 = 1;
    }
}
