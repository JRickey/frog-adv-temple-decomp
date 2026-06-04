#include "types.h"
#include "iwram.h"

extern const u16 sWinPoseScreenCoords[];

extern u8 sub_0801ADA8(u8 arg);
extern u16 gIwram_5398;
void sub_0801B30C(u8 arg0, u8 arg1);

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
    const u32 *tiles;
    const u32 *palette;
    u32 offset;

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

void sub_0801B30C(u8 arg0, u8 arg1)
{
    u32 found;
    const u16 *coords;
    u32 i;
    /* half computed separately to avoid CSE with coords[i*2] address; also forces
       the signed-divide pattern (/ 8 not >> 3) that emits ldrh r2 + adds r0, r2, #4. */
    u32 half;

    found = 0;
    i = 0;
    coords = sWinPoseScreenCoords;
    do {
        if (((s32)coords[i * 2] - 4) / 8 == arg0) {
            half = (u32)(i * 2 + 1);
            if (((s32)coords[half] + 4) / 8 == arg1) {
                found = 1;
            }
        }
        i = (u8)(i + 1);
    } while (i <= 15);

    if (found == 0) {
        *(u16 *)(0x02010000 + (u32)arg1 * 128 + (u32)arg0 * 2) = 0xe307;
    }
}

void sub_0801B374(u8 index)
{
    vu32 *dma;
    u16 zero;
    u16 *zptr;
    u32 tableBase;
    u32 idx24;
    u32 entry;
    const u32 *tiles;
    const u32 *palette;
    u32 offset;

    offset = (u32)index << 24;

    tableBase = 0x080C1254;
    /* anchor the table literal before the gIwram_34B0 address so agbcc keeps
       the +4 add on the table base (not folded into the index multiply). */
    asm volatile("" : "+r"(tableBase));
    idx24 = gIwram_34B0._data * 24;
    tableBase += 4;
    entry = *(const u32 *)(idx24 + tableBase);

    zptr = &zero;
    *zptr = 0;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)zptr;
    dma[1] = 0x0600F800;
    dma[2] = 0x81000400;
    dma[2];

    dma[0] = entry;
    dma[1] = 0x06008000;
    dma[2] = 0x80002000;
    dma[2];

    tiles = (const u32 *)0x08308F08;
    offset = offset >> 22;
    offset += 28;

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

void sub_0801B430(u8 index)
{
    vu32 *dma;
    const u32 *sourceB;
    const u32 *sourceA;
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
    offset += 28;
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
