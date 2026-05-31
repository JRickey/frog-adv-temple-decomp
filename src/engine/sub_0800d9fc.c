#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const u8 sSpriteAnimPermLut[16];

extern u8 gIwram_53A0;
extern void sub_0800D450(u32 a, u32 b);
extern void sub_0800D0F8(void);

s8 sub_0800D9FC(s8 idx)
{
    return (s8)sSpriteAnimPermLut[(s8)idx];
}

void sub_0800DA10(void)
{
    u8 *base;
    u8 *p;
    s8 i;
    /* The 0xB20 zero is materialized into r3 between computing the 0xB22
     * pointer and loading its 0xF0 value, and held live across that store:
     * the r3 pin + the separate `p` pointer + the `zero = 0` placement
     * reproduce baserom's instruction schedule. */
    register u8 zero asm("r3");

    for (i = 0; i <= 0x3f; i++) {
        (&gIwram_53A0)[i] = 0;
    }

    sub_0800D450(20, 10);
    sub_0800D0F8();

    base = (u8 *)&gIwram_3720;
    *(u32 *)(base + 0xB1C) = gGameStuff._unk00;
    p = base + 0xB22;
    zero = 0;
    *p = 0xF0;
    *(u8 *)(base + 0xB20) = zero;
}
