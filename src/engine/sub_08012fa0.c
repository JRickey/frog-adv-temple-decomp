#include "macros.h"
#include "types.h"

void sub_08012FA0(void)
{
    u8 i = 0;
    u8 *base = (u8 *)0x03003610;
    register u8 *ptr asm("r1");
    register u8 mask asm("r0");

    while (i <= 7) {
        if ((base[0xd3] >> i) & 1) {
            if (i <= 7) {
                switch (i) {
                case 0:
                    ptr = base + 0xd4;
                    mask = 0xdf;
                    break;
                case 1:
                    ptr = base + 0xd4;
                    mask = 0xef;
                    break;
                case 2:
                    ptr = base + 0xd4;
                    mask = 0x7f;
                    break;
                case 3:
                    ptr = base + 0xd4;
                    mask = 0xbf;
                    break;
                case 4:
                    ptr = base + 0xd4;
                    mask = 0xfd;
                    break;
                case 5:
                    ptr = base + 0xd4;
                    mask = 0xfe;
                    break;
                case 6:
                    ptr = base + 0xd4;
                    mask = 0xf7;
                    break;
                case 7:
                    ptr = base + 0xd4;
                    mask = 0xfb;
                    break;
                }
                *ptr &= mask;
            }
        }
        i = (u8)(i + 1);
    }
}
