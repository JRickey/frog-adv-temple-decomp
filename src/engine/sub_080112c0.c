#include "game.h"
#include "macros.h"
#include "types.h"

extern void ScaleAnim_BlitFrameToVram(u32 rows, u32 cols, u32 dstX, u32 dstY, u32 bank, const u16 *src, u16 *vram);
extern const u16 ***gFrameCellTable_08307EAC[];

struct BlitState {
    u8 _pad00[26];
    u16 stride;
};

/* Blits a cols x rows block of u16 tiles from the ROM cell table
 * (gFrameCellTable[(gGameStuff.pendingMode - 1) * 5][frame][cell]) into one of
 * three EWRAM banks selected by `bank`, at (dstX, dstY) scaled by the scene
 * stride at gIwram_60A0+26, then tail-calls ScaleAnim_BlitFrameToVram to flush the bank to
 * VRAM. Twin of the (already-matching) sub_08012BC4; like it, the register pins
 * mirror agbcc's prologue allocation and are load-bearing for the match. */
void BlitFrameCell(u32 frameArg, u32 rowsArg, u32 colsArg, u32 dstXArg, u32 dstYArg, u32 bankArg, u32 cellArg)
{
    u32 frame;
    register u32 rows asm("r8");
    register u32 cols asm("ip");
    u32 dstX;
    u32 rowCount;
    register u32 dstY asm("sl");
    s32 bank;
    u32 cell;
    u16 *dst;
    const u16 *src;
    register struct BlitState *state asm("r1");
    register u16 stride asm("r3");
    u32 row;
    u32 nextRow;
    register u16 *vram asm("r7");

    frame = (u8)frameArg;
    rows = (u8)rowsArg;
    cols = (u8)colsArg;
    dstX = (u16)dstXArg;
    dstY = (u16)dstYArg;
    bank = (u8)bankArg;
    cell = (u8)cellArg;

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

    {
        const u16 ****table = gFrameCellTable_08307EAC;
        u32 idx = gGameStuff.pendingMode - 1;
        const u16 **frameTable = table[idx * 5][frame];
        frame = (u32)frameTable[cell];
    }
    src = (const u16 *)frame;

    state = (struct BlitState *)0x030060A0;
    stride = state->stride;
    dst += dstX + stride * dstY;

    /* Re-loading the state pointer here (instead of reusing the value above) is
     * a matching trick: the extra pool reload advances agbcc's reload-register
     * round-robin so the spilled dstX above reloads into r6, matching baserom. */
    state = (struct BlitState *)0x030060A0;
    rowCount = rows;
    row = 0;
    if (row < rowCount) {
        register struct BlitState *loopState asm("r4") = state;

        do {
            u8 col;

            col = 0;
            nextRow = row + 1;
            if (col < cols) {
                do {
                    *dst++ = *src++;
                    col++;
                } while (col < cols);
            }
            dst += loopState->stride - cols;
            row = (u8)nextRow;
        } while (row < rows);
    }

    switch (bank) {
    case 0:
        vram = (u16 *)0x0600E000;
        break;
    case 1:
        vram = (u16 *)0x0600E800;
        break;
    case 2:
        vram = (u16 *)0x0600F000;
        break;
    }

    ScaleAnim_BlitFrameToVram(rows, cols, dstX, dstY, bank, (const u16 *)frame, vram);
}
