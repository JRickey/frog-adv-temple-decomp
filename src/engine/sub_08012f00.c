#include "types.h"

void sub_08012F00(void)
{
    u8 *base;
    register u8 *dst asm("r0");
    u8 i;

    i = 0;
    base = (u8 *)0x03003610;
    for (; i <= 7; i++) {
        if (((base[0xD3] >> i) & 1) != 0) {
            switch (i) {
            case 0: {
                u8 flag;
                dst = base + 0xD4;
                flag = 0x20;
                *dst |= flag;
                break;
            }
            case 1: {
                u8 flag;
                dst = base + 0xD4;
                flag = 0x10;
                *dst |= flag;
                break;
            }
            case 2: {
                u8 flag;
                dst = base + 0xD4;
                flag = 0x80;
                *dst |= flag;
                break;
            }
            case 3: {
                u8 flag;
                dst = base + 0xD4;
                flag = 0x40;
                *dst |= flag;
                break;
            }
            case 4: {
                u8 flag;
                dst = base + 0xD4;
                flag = 2;
                *dst |= flag;
                break;
            }
            case 5: {
                u8 flag;
                dst = base + 0xD4;
                flag = 1;
                *dst |= flag;
                break;
            }
            case 6: {
                u8 flag;
                dst = base + 0xD4;
                flag = 8;
                *dst |= flag;
                break;
            }
            case 7: {
                u8 flag;
                dst = base + 0xD4;
                flag = 4;
                *dst |= flag;
                break;
            }
            }
        }
    }
}
