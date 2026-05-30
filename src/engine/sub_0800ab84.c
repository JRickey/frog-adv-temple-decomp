#include "iwram.h"
#include "macros.h"
#include "types.h"

extern s8 sub_0800A7A8(s8 a, s16 x, s16 y);
extern u8 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern u32 sub_08020C78(u32 sound);

void sub_0800AB84(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    s8 result;
    register u8 *base asm("r0");
    register u8 *base5 asm("r5");
    register u32 bit asm("r2");
    register u8 *checkBase asm("r4");

    if (tile != 20)
        return;

    p35E0 = &gIwram_35E0;
    result = sub_0800A7A8(19, p35E0->_field_8, p35E0->_field_A);

    if (result != 0)
        goto nonzero;

    base = (u8 *)0x03006110;
    bit = (u8)result;
    goto set5;

nonzero:
    base5 = (u8 *)0x03006110;
    bit = (u8)(result - 1);
    if (sub_0800679C(base5, 5, bit) == 0)
        goto play;

    bit = (u8)result;
    base = base5;

set5:
    sub_08006600(base, 5, bit);
    goto check;

play:
    sub_08020C78(114);

check:
    checkBase = (u8 *)0x03006110;
    if (sub_0800679C(checkBase, 5, 0) == 0)
        return;
    if (sub_0800679C(checkBase, 5, 1) == 0)
        return;
    if (sub_0800679C(checkBase, 5, 2) == 0)
        return;
    if (sub_0800679C(checkBase, 5, 3) == 0)
        return;

    sub_08006600(checkBase, 5, 15);
    sub_080066C4(checkBase, 8, 1);
}
