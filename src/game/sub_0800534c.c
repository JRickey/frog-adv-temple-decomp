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
