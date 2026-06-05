#include "types.h"

void sub_080125EC(void)
{
    u8 *unk6410 = (u8 *)0x03006410;
    u32 zero = 0;
    u8 *unk6480;

    unk6410[0x0C] = 8;
    unk6480 = (u8 *)0x03006480;
    *(u16 *)(unk6480 + 0x36) = zero;
}
