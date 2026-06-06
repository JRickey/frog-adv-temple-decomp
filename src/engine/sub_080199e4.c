#include "types.h"

void FrogSelect_ClearInputState(void)
{
    register u32 i asm("r2") = 0;
    register u8 *base asm("r4") = (u8 *)0x03005330;
    register u8 *dst asm("r1") = (u8 *)0x03003610;
    register u8 zero asm("r3") = 0;
    register u8 *ptr asm("r1");
    register u32 next asm("r0");

    do {
        next = i + (u32)dst;
        *(u8 *)next = zero;
        next = i + 1;
        i = (u8)next;
    } while (i <= 21);

    ptr = base;
    ptr += 0x20;
    *ptr = 0;
}
