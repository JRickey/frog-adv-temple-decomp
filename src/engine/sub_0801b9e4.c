#include "types.h"

extern u8 sub_0801B71C(u8 arg);
extern u16 gIwram_5398;

u32 sub_0801B9E4(u8 arg)
{
    register u8 argReg asm("r3") = arg;
    register u32 ret asm("r2") = 1;
    register u8 *state asm("r4") = (u8 *)0x03006440;
    register u32 *frameCounter asm("r5");

    if (*(u16 *)(state + 0x30) == 0)
        state[0x0B] = 8;

    frameCounter = (u32 *)0x03005330;
    if (*frameCounter - *(u32 *)(state + 4) >= state[0x0B]) {
        ret = (u8)sub_0801B71C(argReg);
        *(u32 *)(state + 4) = *frameCounter;
    }

    if (gIwram_5398 == 0x20)
        ret = 0xFE;

    return ret;
}
