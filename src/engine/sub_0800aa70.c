#include "iwram.h"
#include "macros.h"
#include "types.h"

extern s8 sub_0800A7A8(s8 a, s16 x, s16 y);
extern u8 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern void sub_0800A83C(u8 a, u8 b, u8 c, u8 d);

void sub_0800AA70(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    u8 result;
    register u8 *base4 asm("r4");
    register u8 *base5 asm("r5");
    register u8 *exitBase asm("r0");
    register u32 exitBit asm("r2");

    if (tile == 20) {
        p35E0 = &gIwram_35E0;
        result = (u8)sub_0800A7A8(15, p35E0->_field_8, p35E0->_field_A);

        switch ((s8)result) {
        case 0:
            base4 = (u8 *)0x03006110;
            sub_08006600(base4, 5, 6);
            sub_080066C4(base4, 5, 1);
            break;
        case 1:
            base4 = (u8 *)0x03006110;
            sub_08006600(base4, 5, 7);
            sub_080066C4(base4, 5, 0);
            break;
        case 2:
            base5 = (u8 *)0x03006110;
            if (sub_0800679C(base5, 5, 2) == 0) {
                sub_0800A83C(13, p35E0->_field_18, 0, 1);
                sub_08006600(base5, 8, 1);
            }
            break;
        case 3:
            base5 = (u8 *)0x03006110;
            if (sub_0800679C(base5, 5, 3) == 0) {
                sub_0800A83C(14, p35E0->_field_18, 0, 1);
                sub_08006600(base5, 8, 2);
            }
            break;
        }

        exitBase = (u8 *)0x03006110;
        exitBit = result;
        sub_08006600(exitBase, 5, exitBit);
        return;
    }

    if (tile == 21) {
        sub_08006600((u8 *)0x03006110, 3, 0);
        return;
    }

    base4 = (u8 *)0x03006110;
    sub_080066C4(base4, 5, 0);
    sub_080066C4(base4, 5, 1);
}
