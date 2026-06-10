#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

#define DIR_UP    1
#define DIR_DOWN  2
#define DIR_LEFT  4
#define DIR_RIGHT 8
#define DIR_AUTO  16

extern struct SpriteAssetIndexEntry sSpriteAssetIndexTable[];
extern u32 SpriteGrid_GetNeighborTile(u8 col, u8 row, s16 tileX, s16 tileY, u8 dir);

/* Directional passability test against the per-room packed-halfword grid at
 * EWRAM 0x02030000 (one 0x5000-byte slot per `row`, laid out by
 * sSpriteAssetIndexTable[col].stride halfwords per grid line). The low four
 * bits of each cell gate movement: bit3 = up, bit2 = down, bit1 = left,
 * bit0 = right. DIR_AUTO re-checks in the direction the slot-0 entity is
 * moving (gEntities[0].state 0..3 = up/down/left/right): pass if both the
 * current cell and the next cell open that way, or if the neighbor tile
 * class (SpriteGrid_GetNeighborTile) is 1 and the next cell opens that way.
 *
 * Matching notes (agbcc 2.x):
 *   - Per-arm product forms differ on purpose: `y *= stride` vs
 *     `prod = stride * y` reproduce the baserom's per-site muls destination.
 *   - The DIR_AUTO second reads spell the redundant `(s16)y`/`(s16)stride`
 *     casts out even though both values are already in range: combine folds
 *     them away (zero bytes), but global-alloc priorities are computed
 *     earlier (at flow), and the extra extension insns lengthen the shared
 *     tileX<<16 temp's live range just enough to demote it below the y-cast
 *     scratch in allocation order. That single demotion flips the whole
 *     callee-saved assignment to the baserom's coloring (col=r9, col*8=sl,
 *     x<<16=ip, row*4=r7). Removing any of the four casts breaks the match.
 *   - case 3 nests its post-call check under `== 1` (the other arms use
 *     `!= 1 return 0`) so its return-0 block lands after the bounds check,
 *     exactly as the baserom lays it out. */
u8 sub_0800C4E8(u8 col, u8 row, u16 tileX, u16 tileY, u8 dir)
{
    switch (dir) {
    case DIR_UP: {
        s32 y = (s16)tileY;

        if (y - 1 < 0) {
            return 0;
        }
        y *= sSpriteAssetIndexTable[col].stride;
        return (u16)(*(u16 *)(2 * (s16)tileX + (2 * y + 5 * row * 4096) + (u8 *)0x02030000) & 8) >> 3;
    }

    case DIR_DOWN: {
        s32 y = (s16)tileY;
        s32 prod;

        if (y + 1 >= sSpriteAssetIndexTable[col].rows) {
            return 0;
        }
        prod = sSpriteAssetIndexTable[col].stride * y;
        return (u16)(*(u16 *)(2 * (s16)tileX + (2 * prod + 5 * row * 4096) + (u8 *)0x02030000) & 4) >> 2;
    }

    case DIR_LEFT: {
        s32 x = (s16)tileX;
        s32 y;

        if (x - 1 < 0) {
            return 0;
        }
        y = (s16)tileY;
        y *= sSpriteAssetIndexTable[col].stride;
        return (u16)(*(u16 *)(2 * x + (2 * y + 5 * row * 4096) + (u8 *)0x02030000) & 2) >> 1;
    }

    case DIR_RIGHT: {
        s32 x = (s16)tileX;
        s32 nextX = x + 1;
        s32 stride = sSpriteAssetIndexTable[col].stride;

        if (nextX >= stride) {
            return 0;
        }
        stride *= (s16)tileY;
        return *(u8 *)(2 * x + (2 * stride + 5 * row * 4096) + (u8 *)0x02030000) & 1;
    }

    case DIR_AUTO:
        switch (gEntities[0].state) {
        case 0: {
            s32 y = (s16)tileY;
            s32 stride;
            s32 prod;
            s32 prod2;

            if (y - 2 < 0) {
                return 0;
            }
            stride = sSpriteAssetIndexTable[col].stride;
            prod = y * stride;
            if (*(u16 *)(2 * (s16)tileX + (2 * prod + 5 * row * 4096) + (u8 *)0x02030000) & 8) {
                if (*(u16 *)(2 * (((s16)y - 1) * (s16)stride) + 5 * row * 4096 + 2 * (s16)tileX + (u8 *)0x02030000) &
                    8) {
                    return 1;
                }
            }
            if ((u8)SpriteGrid_GetNeighborTile(col, row, (s16)tileX, (s16)tileY, DIR_UP) != 1) {
                return 0;
            }
            prod2 = ((s16)tileY - 1) * sSpriteAssetIndexTable[col].stride;
            if (*(u16 *)(2 * (s16)tileX + (2 * prod2 + 5 * row * 4096) + (u8 *)0x02030000) & 8) {
                return 1;
            }
            return 0;
        }

        case 1: {
            s32 y = (s16)tileY;
            s32 stride;
            s32 prod;
            s32 prod2;

            if (y + 2 >= sSpriteAssetIndexTable[col].rows) {
                return 0;
            }
            stride = sSpriteAssetIndexTable[col].stride;
            prod = y * stride;
            if (*(u16 *)(2 * (s16)tileX + (2 * prod + 5 * row * 4096) + (u8 *)0x02030000) & 4) {
                if (*(u16 *)(2 * (((s16)y + 1) * (s16)stride) + 5 * row * 4096 + 2 * (s16)tileX + (u8 *)0x02030000) &
                    4) {
                    return 1;
                }
            }
            if ((u8)SpriteGrid_GetNeighborTile(col, row, (s16)tileX, (s16)tileY, DIR_DOWN) != 1) {
                return 0;
            }
            prod2 = ((s16)tileY + 1) * sSpriteAssetIndexTable[col].stride;
            if (*(u16 *)(2 * (s16)tileX + (2 * prod2 + 5 * row * 4096) + (u8 *)0x02030000) & 4) {
                return 1;
            }
            return 0;
        }

        case 2: {
            s32 x = (s16)tileX;
            s32 prod;
            s32 prod2;

            if (x - 2 < 0) {
                return 0;
            }
            prod = (s16)tileY * sSpriteAssetIndexTable[col].stride;
            if ((*(u16 *)(2 * x + (2 * prod + 5 * row * 4096) + (u8 *)0x02030000) & 2) >> 1) {
                if ((*(u16 *)(2 * x + (2 * prod + 5 * row * 4096) + (u8 *)0x0202FFFE) & 2) >> 1) {
                    return 1;
                }
            }
            if ((u8)SpriteGrid_GetNeighborTile(col, row, (s16)tileX, (s16)tileY, DIR_LEFT) != 1) {
                return 0;
            }
            prod2 = sSpriteAssetIndexTable[col].stride * (s16)tileY;
            if (*(u16 *)(2 * (s16)tileX + (2 * prod2 + 5 * row * 4096) + (u8 *)0x0202FFFE) & 2) {
                return 1;
            }
            return 0;
        }

        case 3: {
            s32 x = (s16)tileX;
            s32 nextX = x + 2;
            s32 stride = sSpriteAssetIndexTable[col].stride;
            s32 prod;
            s32 prod2;

            if (nextX >= stride) {
                return 0;
            }
            prod = (s16)tileY * stride;
            if (*(u16 *)(2 * x + (2 * prod + 5 * row * 4096) + (u8 *)0x02030000) & 1) {
                if (*(u16 *)(2 * x + (2 * prod + 5 * row * 4096) + (u8 *)0x02030002) & 1) {
                    return 1;
                }
            }
            if ((u8)SpriteGrid_GetNeighborTile(col, row, (s16)tileX, (s16)tileY, DIR_RIGHT) == 1) {
                prod2 = sSpriteAssetIndexTable[col].stride * (s16)tileY;
                if (*(u16 *)(2 * (s16)tileX + (2 * prod2 + 5 * row * 4096) + (u8 *)0x02030002) & 1) {
                    return 1;
                }
            }
            return 0;
        }
        }
    }
}
