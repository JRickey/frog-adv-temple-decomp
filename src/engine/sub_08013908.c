#include "macros.h"
#include "types.h"
#include "game.h"

extern void sub_0800EE34(u8 layer);

/* Clears the byte at IWRAM 0x03003610, then turns off BG2 via sub_0800EE34. */

void sub_08013908(void)
{
    *(u8 *)0x03003610 = 0;
    sub_0800EE34(2);
}

void sub_08013920(u16 *arr, u8 thresh, u32 *out, u8 n)
{
    GameStuff *gs;
    GameStuff *gsBase;
    u8 i;
    register u16 prev asm("r2");
    register u16 cur asm("r6");

    gsBase = &gGameStuff;
    {
        u32 diff = gsBase->_unk00 - out[1];
        gs = gsBase;
        if (diff < thresh)
            return;
    }

    prev = arr[0];
    i = 0;

    if (i < n) {
        int nm1 = n - 1;
        u32 step = (u32)n * 2 - 2;

    loop:
        if (i < nm1) {
            cur = arr[1];
            arr++;
            arr[0] = prev;
            prev = cur;
            goto inc;
        }
        arr = (u16 *)((u8 *)arr - step);
        arr[0] = cur;
    inc:
        i = (u8)(i + 1);
        if (i < n)
            goto loop;
    }

    {
        register GameStuff *gsEp asm("r1");
        u32 *outEp;
        u32 val;
        gsEp = gs;
        val = gsEp->_unk00;
        outEp = out;
        outEp[1] = val;
    }
}
