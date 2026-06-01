#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const u8 sSpriteAnimPermLut[16];

extern u8 gIwram_53A0;
extern u32 *sub_0800D070(u32 *out, s8 delta);
extern u32 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern void sub_0800D450(u32 a, u32 b);
extern void sub_0800D0F8(void);
extern u32 sub_0800DAB8(s32 bit);

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

u32 sub_0800DA70(u32 val)
{
    u32 result = val;
    u32 shifted = val;
    u32 cnt;
    u32 one;
    s8 bit;

    cnt = 0;
    one = 1;
    do {
        if (shifted & one) {
            bit = (s8)(cnt << 24 >> 24);
            if (sub_0800DAB8(bit) == 0) {
                result &= ~(one << bit);
            }
        }
        shifted >>= 1;
        cnt = (u32)((cnt << 24) + 0x1000000) >> 24;
        bit = (s8)((cnt << 24) >> 24);
    } while (bit <= 24);

    return result;
}

u32 sub_0800DAB8(s32 bit)
{
    u32 coord;
    s16 tileX;
    s16 tileY;
    s8 tile;

    sub_0800D070(&coord, (s8)bit);
    tileX = (s16)coord;
    tileY = (s16)(coord >> 16);
    tile = (s8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, tileX, tileY);
    if ((u8)(tile - 1) <= 1 || tile == 21 || tile == 20)
        return 0;

    return 1;
}
