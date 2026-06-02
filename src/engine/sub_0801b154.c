#include "types.h"

struct Sub0801B154Bits {
    u8 pad00[0x0C];
    u32 bits;
};

u8 sub_0801B154(void)
{
    s8 i = 15;
    u32 bits = ((struct Sub0801B154Bits *)0x03005330)->bits;

    while (i >= 0) {
        if (((bits >> i) & 1) != 0) {
            return (u8)(i + 1);
        }
        i--;
    }

    return 0;
}

u8 sub_0801B188(u32 bits)
{
    s8 i = 15;

    while (i >= 0) {
        if (((bits >> i) & 1) != 0) {
            return (u8)(i + 1);
        }
        i--;
    }

    return 0;
}

void sub_0801B1B4(u8 index)
{
    vu32 *dma;
    register const u32 *tiles asm("r4");
    const u32 *palette;
    register u32 offset asm("r0");

    offset = (u32)index << 24;
    dma = (vu32 *)0x040000D4;
    tiles = (const u32 *)0x08308F08;
    offset = offset >> 22;
    offset += 4;

    dma[0] = *(const u32 *)(offset + (u32)tiles);
    dma[1] = 0x06008020;
    dma[2] = 0x80000100;
    dma[2];

    dma[0] = tiles[0];
    dma[1] = 0x06008220;
    dma[2] = 0x80000100;
    dma[2];

    palette = (const u32 *)0x08308F3C;
    dma[0] = palette[0];
    dma[1] = 0x050001A0;
    dma[2] = 0x80000010;
    dma[2];

    dma[0] = *(const u32 *)((u32)palette + offset);
    dma[1] = 0x050001E0;
    dma[2] = 0x80000010;
    dma[2];
}
