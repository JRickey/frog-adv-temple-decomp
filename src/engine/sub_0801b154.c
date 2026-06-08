#include "types.h"
#include "iwram.h"

extern const u16 sWinPoseScreenCoords[];

extern u8 Credits_RunScript(u8 arg);
extern u16 gIwram_5398;
void WorldMap_SetPathTile(u8 arg0, u8 arg1);

struct Sub0801B154Bits {
    u8 pad00[0x0C];
    u32 bits;
};

u8 GetHighestUnlockedWorld(void)
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

u8 CountHighestBit(u32 bits)
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

void Room_LoadTilesAndPalette(u8 index)
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

u8 CreditsRoll_StepThrottled(u8 arg)
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
        result = Credits_RunScript(arg);
        state->lastTime = *timer;
    }

    if (gIwram_5398 == 0x20) {
        result = 0xFE;
    }

    return result;
}

void sub_0801B274(void)
{}

void WorldMap_DrawPathTiles(u8 count)
{
    vu32 *dma;
    const u8 *const *entries;
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
                WorldMap_SetPathTile(entry[j * 2], entry[j * 2 + 1]);
            }
            i++;
        } while (i <= count);
    }
}

void WorldMap_SetPathTile(u8 arg0, u8 arg1)
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
    vu32 *pDma3;
    u16 zeroBuf;
    u16 *pZero;
    u32 roomTableBase;
    u32 roomEntryOff;
    u32 tilesSrc;
    const u32 *pTileSheet;
    const u32 *pPalette;
    u32 indexedOff;

    indexedOff = (u32)index << 24;

    roomTableBase = 0x080C1254;
    /* anchor the table literal before the gIwram_34B0 address so agbcc keeps
       the +4 add on the table base (not folded into the index multiply). */
    asm volatile("" : "+r"(roomTableBase));
    roomEntryOff = gIwram_34B0._data * 24;
    roomTableBase += 4;
    tilesSrc = *(const u32 *)(roomEntryOff + roomTableBase);

    pZero = &zeroBuf;
    *pZero = 0;
    pDma3 = (vu32 *)0x040000D4;
    pDma3[0] = (u32)pZero;
    pDma3[1] = 0x0600F800;
    pDma3[2] = 0x81000400;
    pDma3[2];

    pDma3[0] = tilesSrc;
    pDma3[1] = 0x06008000;
    pDma3[2] = 0x80002000;
    pDma3[2];

    pTileSheet = (const u32 *)0x08308F08;
    indexedOff = indexedOff >> 22;
    indexedOff += 28;

    pDma3[0] = *(const u32 *)(indexedOff + (u32)pTileSheet);
    pDma3[1] = 0x06008020;
    pDma3[2] = 0x80000100;
    pDma3[2];

    pDma3[0] = pTileSheet[0];
    pDma3[1] = 0x06008220;
    pDma3[2] = 0x80000100;
    pDma3[2];

    pPalette = (const u32 *)0x08308F3C;
    pDma3[0] = pPalette[0];
    pDma3[1] = 0x050001A0;
    pDma3[2] = 0x80000010;
    pDma3[2];

    pDma3[0] = *(const u32 *)((u32)pPalette + indexedOff);
    pDma3[1] = 0x050001E0;
    pDma3[2] = 0x80000010;
    pDma3[2];
}

void Room_LoadSpriteTiles(u8 index)
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
