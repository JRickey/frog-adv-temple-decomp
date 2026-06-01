#include "types.h"

void sub_08012F00(void)
{
    u8 *base;
    u8 i;

    i = 0;
    base = (u8 *)0x03003610;
    for (; i <= 7; i++) {
        if (((base[0xD3] >> i) & 1) != 0) {
            switch (i) {
            case 0: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 0x20;
                *dst |= flag;
                break;
            }
            case 1: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 0x10;
                *dst |= flag;
                break;
            }
            case 2: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 0x80;
                *dst |= flag;
                break;
            }
            case 3: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 0x40;
                *dst |= flag;
                break;
            }
            case 4: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 2;
                *dst |= flag;
                break;
            }
            case 5: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 1;
                *dst |= flag;
                break;
            }
            case 6: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 8;
                *dst |= flag;
                break;
            }
            case 7: {
                register u8 *dst asm("r0");
                register u8 flag asm("r1");
                dst = base + 0xD4;
                flag = 4;
                *dst |= flag;
                break;
            }
            }
        }
    }
}
