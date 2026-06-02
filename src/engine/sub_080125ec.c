#include "types.h"

void sub_080125EC(void)
{
    register u8 *unk6410 asm("r1") = (u8 *)0x03006410;
    register u32 zero asm("r2") = 0;
    u8 *unk6480;

    unk6410[0x0C] = 8;
    unk6480 = (u8 *)0x03006480;
    *(u16 *)(unk6480 + 0x36) = zero;
}
