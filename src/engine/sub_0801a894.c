#include "gba/io.h"
#include "types.h"

extern s32 __divsi3(s32 num, s32 den);
extern void sub_080008DC(void);

void sub_0801A894(u32 flags, u32 count)
{
    vu16 *win0h;
    vu16 *win0v;
    u16 full;
    u8 bottomStep;
    u8 step;
    u8 flagBits;
    u8 top;
    u8 bottom;
    u8 i;
    s32 num;
    s32 den;

    flagBits = (u8)flags;
    i = (u8)count;
    num = 56;
    den = i;
    step = (u8)__divsi3(num, den);
    bottomStep = step;
    top = 0xA0;
    bottom = 0;

    if (flagBits & 1) {
        REG_DISPCNT |= DISPCNT_WIN0_ON;
    }
    if (flagBits & 2) {
        REG_DISPCNT |= DISPCNT_WIN1_ON;
    }

    i++;
    if (i != 0) {
        win0h = (vu16 *)0x04000040;
        full = 0xF0;
        win0v = (vu16 *)0x04000044;
        do {
            *win0h = full;
            *win0v = (top << 8) | 0xA0;
            *(vu16 *)0x04000042 = full;
            *(vu16 *)0x04000046 = bottom;
            sub_080008DC();
            top = (u8)(top - step);
            bottom = (u8)(bottom + bottomStep);
            i = (u8)(i - 1);
        } while (i != 0);
    }

    *(vu16 *)0x04000040 = 0xF0;
    *(vu16 *)0x04000044 = 0x70A0;
    *(vu16 *)0x04000042 = 0xF0;
    *(vu16 *)0x04000046 = 0x30;
    REG_DISPCNT |= DISPCNT_BG3_ON;
}
