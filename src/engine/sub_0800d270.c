#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 gIwram_53A0;

u8 sub_0800D270(u32 x, u32 y)
{
    register s32 sx asm("r2");
    register s32 dcol asm("r3");
    register s32 t asm("r0"); /* pin forces subs r0,r2,#3 (3-operand) for col2 check */
    s32 row;

    y = (u16)y;
    sx = (s16)x;
    dcol = sx - 3;

    if ((u16)dcol > 7)
        return 0;
    y = (s32)(s16)y;
    if ((s32)y <= 4)
        return 0;
    if ((s32)y > 12)
        return 0;

    t = sx - 3;
    if ((u16)t > 8)
        goto ret_ff;
    row = (s32)y;
    if (row <= 4)
        goto ret_ff;
    if (row <= 13)
        goto compute;
ret_ff:
    row = 0xFF;
    goto common;
compute:
    row = (row - 5) * 8 + dcol;
common:
    return (&gIwram_53A0)[(u8)row];
}
