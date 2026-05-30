#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern u32 sub_08011884(void);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);

void sub_0800534C(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;

    if ((u8)sub_0800679C(base6110, 3, 8) == 0)
        return;
    if ((u8)sub_08011884() == 0)
        return;

    {
        register u32 *g asm("r1") = (u32 *)0x03005330;
        u8 *base3720 = (u8 *)&gIwram_3720;

        if (*g - *(u32 *)(base3720 + 0xb10) <= 120)
            return;
    }
    sub_08006600(base6110, 3, 3);
    sub_080066C4(base6110, 3, 8);
}

extern u32 sub_08009C14(u8 *state);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);

void sub_080053A4(u8 *arg0, u8 *arg1, u32 *arg2, u8 *arg3, u32 *arg4)
{
    if (sub_08009C14(arg0) == 0)
        *arg0 = 8;

    {
        u8 *base = (u8 *)&gIwram_6110;
        gIwram_6110._field_10 = 0;
        base[0x2a] = 0;
        base[0x2b] = 0;

        if (gIwram_6110._field_33 != 1)
            return;
    }

    sub_0800BE18(arg1, arg2, 29);
    sub_0800BE18(arg3, arg4, 30);
}

extern void sub_08015A00(void);
extern void sub_0800DE80(void);

void sub_080053F4(void)
{
    sub_08015A00();
    sub_0800DE80();
}
