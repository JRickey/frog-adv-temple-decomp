#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Field-extract helper on the per-room packed-halfword grid at EWRAM
 * 0x02030000. Sister functions SpriteAsset_GetCellFlag / SpriteAsset_GetTileAttr / TileCell_GetPropertyB
 * differ only in which bitfield they pull from the halfword. The grid
 * stride (entry_descriptor[+4]) comes from sSpriteAssetIndexTable at
 * 0x08306444 (see src/data/sprite_dispatch.c). */

extern const struct SpriteAssetIndexEntry sSpriteAssetIndexTable[];

u32 Tilemap_GetTileClass(u8 a, u8 b, s16 c, s16 d)
{
    s32 dStride;
    u16 *cell;

    dStride = d * sSpriteAssetIndexTable[(u8)a].stride;
    cell = (u16 *)(2 * c + (5 * b * 4096 + 2 * dStride) + 0x02030000);
    return (*cell & 0x3F0) >> 4;
}
