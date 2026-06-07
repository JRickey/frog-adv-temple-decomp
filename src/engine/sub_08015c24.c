#include "iwram.h"
#include "types.h"

extern struct BgScrollState gIwram_60A0[3];

/* Blit a cols x rows rectangle of u16 tile entries from src into one of three
 * EWRAM tilemap banks, placed at (dstX, dstY) and advancing by the bank stride
 * (tileCols) between rows. */
void BlitTilesRect(u8 bank, u16 dstX, u16 dstY, u8 cols, u8 rows, const u16 *src)
{
    u16 *dst;
    struct BgScrollState *state;
    register s32 x asm("r1");
    register s32 y asm("r0");
    /* dstX is a u16 arg; sign-extend it through an r0 scratch (lsls/asrs) the
     * way the baserom does, rather than the in-place (s16) cast agbcc would
     * otherwise emit. */
    register s32 xScratch asm("r0");
    register u32 row asm("r0");
    register u8 nextRow asm("r1");

    switch (bank) {
    case 0:
        dst = (u16 *)0x02000000;
        break;
    case 1:
        dst = (u16 *)0x02010000;
        break;
    case 2:
        dst = (u16 *)0x02020000;
        break;
    }

    xScratch = dstX << 16;
    x = xScratch >> 16;
    y = (s16)dstY;
    state = gIwram_60A0;
    y *= state->tileCols;
    {
        /* Pin the offset to r0 so the base index add lands as `adds r0, r1, r0`
         * (x as op1, the y*tileCols product as op2). With x left as op1 the
         * result cannot reuse x's r1, forcing the commutative swap agbcc would
         * otherwise resolve to `adds r0, r0, r1`. */
        register s32 off asm("r0") = x + y;
        dst += off;
    }

    row = 0;
    if (row < rows) {
        struct BgScrollState *loopState = state;
        do {
            u8 col = 0;
            nextRow = row + 1;
            if (col < cols) {
                do {
                    *dst++ = *src++;
                    col++;
                } while (col < cols);
            }
            dst += loopState->tileCols - cols;
            row = (u8)nextRow;
        } while (row < rows);
    }
}
