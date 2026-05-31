#include "types.h"

void sub_080008DC(void);

void sub_0801A980(u8 flags, u8 count_)
{
    register s32 count asm("r4") = count_;
    u32 left = 104;
    u8 step = 56 / count;
    u8 top = 56;
    u32 stepc = step;
    register s32 countPlusOne asm("r0") = count + 1;
    u8 n = countPlusOne;

    if (n != 0) {
        do {
            *(vu16 *)0x04000040 = 0xf0;
            *(vu16 *)0x04000044 = (left << 8) | 0xa0;
            *(vu16 *)0x04000042 = 0xf0;
            *(vu16 *)0x04000046 = top;
            sub_080008DC();
            {
                u32 newLeft = left + step;
                left = (u8)newLeft;
            }
            top = (u8)(top - stepc);
            n = n - 1;
        } while (n != 0);
    }

    *(vu16 *)0x04000040 = 0xf0;
    *(vu16 *)0x04000044 = 0xa0;
    *(vu16 *)0x04000042 = 0xf0;
    *(vu16 *)0x04000046 = 0;
    *(vu16 *)0x04000000 &= 0xf7ff;

    if (flags & 1) {
        *(vu16 *)0x04000000 &= 0xdfff;
    }

    if (flags & 2) {
        *(vu16 *)0x04000000 &= 0xbfff;
    }
}
