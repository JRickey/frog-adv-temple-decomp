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

void sub_0801AA60(u8 index)
{
    vu32 *dma;
    const u32 *sourceA;
    const u32 *sourceB;
    const u32 *palette;
    u32 offset;

    offset = (u32)index << 24;
    sourceA = (const u32 *)0x081DAB78;
    sourceB = (const u32 *)0x081DAB58;
    dma = (vu32 *)0x040000D4;

    palette = (const u32 *)0x08308F3C;
    dma[0] = palette[0];
    dma[1] = 0x050001E0;
    dma[2] = 0x80000010;
    dma[2];

    dma[0] = (u32)sourceB;
    dma[1] = 0x0600FBF4;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceB + 8;
    dma[1] = 0x0600FC34;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceB + 16;
    dma[1] = 0x0600FC74;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceB + 24;
    dma[1] = 0x0600FCB4;
    dma[2] = 0x80000004;
    dma[2];

    offset = offset >> 22;
    offset += 4;
    dma[0] = *(const u32 *)(offset + (u32)palette);
    dma[1] = 0x050001E0;
    dma[2] = 0x80000010;
    dma[2];

    dma[0] = (u32)sourceA;
    dma[1] = 0x0600F841;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceA + 8;
    dma[1] = 0x0600F881;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceA + 16;
    dma[1] = 0x0600F8C1;
    dma[2] = 0x80000004;
    dma[2];

    dma[0] = (u32)sourceA + 24;
    dma[1] = 0x0600F901;
    dma[2] = 0x80000004;
    dma[2];
}
