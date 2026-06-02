#include "types.h"

extern u8 sub_0801ADA8(u8 arg);
extern void sub_0801B30C(u8 arg0, u8 arg1);
extern u16 gIwram_5398;

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

struct Sub0801B224State {
    u8 pad00[4];
    u32 lastTime;
    u8 pad08[3];
    u8 delay;
    u8 pad0c[36];
    u16 gate;
};

u8 sub_0801B224(u8 arg)
{
    struct Sub0801B224State *state;
    u32 *timer;
    u8 result;

    result = 1;
    state = (struct Sub0801B224State *)0x03006440;
    if (state->gate == 0) {
        state->delay = 8;
    }

    timer = (u32 *)0x03005330;
    if (*timer - state->lastTime >= state->delay) {
        result = sub_0801ADA8(arg);
        state->lastTime = *timer;
    }

    if (gIwram_5398 == 0x20) {
        result = 0xFE;
    }

    return result;
}

void sub_0801B274(void)
{}

void sub_0801B278(u8 count)
{
    vu32 *dma;
    register const u8 *const *entries asm("r9");
    u16 fill;
    u8 i;
    const u8 *entry;
    u8 j;
    u8 entryCount;

    *(vu32 *)((u32)&fill + (fill = 0), 0x040000D4) = (u32)&fill;
    dma = (vu32 *)0x040000D4;
    dma[1] = 0x02010000;
    dma[2] = 0x81008000;
    dma[2];

    dma[0] = (u32)&fill + (fill = 0);
    dma[1] = 0x0600E800;
    dma[2] = 0x81000400;
    dma[2];

    i = 0;
    if (i <= count) {
        entries = (const u8 *const *)0x08308124;
        do {
            entry = entries[i];
            entryCount = entry[0];
            for (j = 1; j <= entryCount; j++) {
                sub_0801B30C(entry[j * 2], entry[j * 2 + 1]);
            }
            i++;
        } while (i <= count);
    }
}
