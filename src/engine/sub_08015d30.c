#include "types.h"

void sub_08015D30(void)
{
    u8 *a = (u8 *)0x03006540;
    register u32 zero asm("r3") = 0;

    *(u16 *)(a + 0x34) = 0;
    {
        u8 *b = (u8 *)0x03006480;

        *(u16 *)(b + 0x36) = 0xC0;
        a[0x0B] = zero;
        b[0x0B] = 4;
        a[0x09] = zero;
        b[0x09] = 2;
    }
}
