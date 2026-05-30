#include "iwram.h"
#include "macros.h"
#include "types.h"

extern s8 sub_0800A7A8(s8 a, s16 x, s16 y);
extern u8 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_0800A83C(u8 a, u8 b, u8 c, u8 d);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);

void sub_0800A9D4(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    u8 *base6110;
    u8 result;
    register u8 *exitBase asm("r0");
    register u32 exitBit asm("r2");

    if (tile != 20)
        return;

    p35E0 = &gIwram_35E0;
    result = (u8)sub_0800A7A8(8, p35E0->_field_8, p35E0->_field_A);

    switch ((s8)result) {
    case 2:
        base6110 = (u8 *)0x03006110;
        if (sub_0800679C(base6110, 5, 2) == 0) {
            sub_0800A83C(9, p35E0->_field_18, 0, 1);
            sub_08006600(base6110, 8, 0);
        }
        break;
    case 3:
        base6110 = (u8 *)0x03006110;
        if (sub_0800679C(base6110, 5, 3) == 0) {
            sub_0800A83C(10, p35E0->_field_18, 0, 1);
            sub_08006600(base6110, 8, 1);
        }
        break;
    }

    exitBase = (u8 *)0x03006110;
    exitBit = result;
    sub_08006600(exitBase, 5, exitBit);
}
