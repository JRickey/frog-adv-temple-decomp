#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* --- PadGrid_DeactivateEntityAtPos: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 gIwram_53A0;
extern u8 TileMap_GetCell(s32 x, s32 y);

/* Per-TU flag (Makefile), optional: sub_0800d2c0.s: CFLAGS += -fforce-addr
   (byte_diff 259 with or without it). */

void PadGrid_DeactivateEntityAtPos(s16 x, s16 y)
{
    u32 ux, uy, mode;
    struct Entity *e;
    s8 i;
    u16 col, row;
    s32 scol, srow, dcol, rowv, idx;
    u16 status, t;

    ux = (u16)x;
    uy = (u16)y;
    mode = (u8)TileMap_GetCell((s16)x, (s16)y);

    if (mode == 1) {
        for (i = 0; i <= 19; i++) {
            e = (struct Entity *)((u8 *)gEntities + (i + 3) * 56);
            status = e->status;
            if (status & 8)
                continue;
            col = (u16)(e->x / 24);
            row = (u16)(e->y / 24);
            scol = (s16)col;
            if ((s16)col != (s16)ux)
                continue;
            srow = (s16)row;
            if ((s16)row != (s16)uy)
                continue;
            t = 8;
            t |= status;
            t |= 4;
            e->status = t;
            dcol = scol - 3;
            if ((u16)dcol > 7)
                return;
            rowv = srow;
            if (rowv <= 4)
                return;
            if (rowv > 12)
                return;
            if ((u16)dcol > 8)
                goto ff1;
            if (rowv <= 4)
                goto ff1;
            if (rowv <= 13)
                goto co1;
        ff1:
            idx = 0xFF;
            goto cm1;
        co1:
            idx = (rowv - 5) * 8 + dcol;
        cm1:
            (&gIwram_53A0)[(u8)idx] = 0;
            return;
        }
    }

    if (mode != 2)
        return;

    for (i = 0; i <= 9; i++) {
        e = (struct Entity *)((u8 *)gEntities + (i + 23) * 56);
        status = e->status;
        if (status & 8)
            continue;
        col = (u16)(e->x / 24);
        row = (u16)(e->y / 24);
        scol = (s16)col;
        if ((s16)col != (s16)ux)
            continue;
        srow = (s16)row;
        if ((s16)row != (s16)uy)
            continue;
        t = 8;
        t |= status;
        t |= 4;
        e->status = t;
        dcol = scol - 3;
        if ((u16)dcol > 7)
            return;
        rowv = srow;
        if (rowv <= 4)
            return;
        if (rowv > 12)
            return;
        if ((u16)dcol > 8)
            goto ff2;
        if (rowv <= 4)
            goto ff2;
        if (rowv <= 13)
            goto co2;
    ff2:
        idx = 0xFF;
        goto cm2;
    co2:
        idx = (rowv - 5) * 8 + dcol;
    cm2:
        (&gIwram_53A0)[(u8)idx] = 0;
        return;
    }
}
#endif /* NON_MATCHING */
