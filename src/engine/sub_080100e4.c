#include "types.h"

/* --- Scroll_FlushTilemapWindow: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "types.h"

struct ScrollState {
    /* 0x00 */ u8 _pad00[4];
    /* 0x04 */ s32 scrollX;
    /* 0x08 */ s32 scrollY;
    /* 0x0C */ u8 _pad0C[12];
    /* 0x18 */ u16 tileRows;
    /* 0x1A */ u16 tileCols;
    /* 0x1C */ u8 _pad1C[4];
};

#define gScrollState ((struct ScrollState *)0x030060a0)

void Scroll_FlushTilemapWindow(u32 bankArg, const u16 *src, u16 *dst)
{
    struct ScrollState *state;
    u32 bank;
    u16 *base;
    u16 *rowEnd;
    s32 srcX;
    s32 srcY;
    s32 dstX;
    s32 dstY;
    s32 row;
    s32 col;
    u32 xSpan;
    u32 xCountdown;

    base = dst;
    bank = (u8)bankArg;
    srcX = 0;
    srcY = 0;
    state = gScrollState;

    if (*(s32 *)((u8 *)&state->scrollY + (bank << 5)) > 47) {
        if (*(s32 *)((u8 *)&state->scrollY + (bank << 5)) <= state->tileRows * 8 - 208)
            srcY = (u8)((*(s32 *)((u8 *)&state->scrollY + (bank << 5)) - 48) / 8);
    }
    if (*(s32 *)((u8 *)&state->scrollY + (bank << 5)) > state->tileRows * 8 - 208)
        srcY = (u8)((u8)state->tileRows - 32);

    if (*(s32 *)((u8 *)&state->scrollX + (bank << 5)) > 7) {
        if (*(s32 *)((u8 *)&state->scrollX + (bank << 5)) <= state->tileCols * 8 - 248)
            srcX = (u8)((*(s32 *)((u8 *)&state->scrollX + (bank << 5)) - 8) / 8);
    }
    if (*(s32 *)((u8 *)&state->scrollX + (bank << 5)) > state->tileCols * 8 - 248)
        srcX = (u8)((u8)state->tileCols - 32);

    src += srcY * state->tileCols + srcX;

    dstY = srcY & 31;
    dstX = srcX & 31;
    xSpan = (u8)(32 - dstX);
    dst += dstY * 32 + dstX;

    rowEnd = base + 0x800 / 2;

    row = 0;
    do {
        xCountdown = xSpan;
        col = 0;
        row++;
        do {
            if (dst >= rowEnd)
                dst = base + (dst - 0x800 / 2 - base);
            if (dst < base)
                dst = rowEnd - (base - dst);

            if (xCountdown == 0) {
                dst -= 0x40 / 2;
                if (dst < base)
                    dst = base + (0x800 - 0x40) / 2;
            }

            *dst++ = *src++;
            xCountdown = (u8)(xCountdown - 1);
            col = (u8)(col + 1);
        } while (col <= 31);

        src += state->tileCols - 32;
        if (xSpan != 32)
            dst += 0x40 / 2;
    } while ((u8)row <= 31);
}
#endif /* NON_MATCHING */
