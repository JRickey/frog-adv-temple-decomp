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

u32 Tilemap_GetTileClass(u8 assetIndex, u8 bank, s16 column, s16 row)
{
    s32 dStride;
    u16 *cell;

    dStride = row * sSpriteAssetIndexTable[(u8)assetIndex].stride;
    cell = (u16 *)(2 * column + (5 * bank * 4096 + 2 * dStride) + 0x02030000);
    return (*cell & 0x3F0) >> 4;
}

u32 SpriteAsset_GetCellFlag(u8 assetIndex, u8 bank, s16 column, s16 row)
{
    s32 dStride;
    u16 *cell;

    dStride = row * sSpriteAssetIndexTable[(u8)assetIndex].stride;
    cell = (u16 *)(2 * column + (5 * bank * 4096 + 2 * dStride) + 0x02030000);
    return (*cell & 0x4000) >> 14;
}

u32 SpriteAsset_GetTileAttr(u8 assetIndex, u8 bank, s16 column, s16 row)
{
    s32 dStride;
    u16 *cell;

    dStride = row * sSpriteAssetIndexTable[(u8)assetIndex].stride;
    cell = (u16 *)(2 * column + (5 * bank * 4096 + 2 * dStride) + 0x02030000);
    return (*cell & 0x3000) >> 12;
}

u32 TileCell_GetPropertyB(u8 assetIndex, u8 bank, s16 column, s16 row)
{
    s32 dStride;
    u16 *cell;

    dStride = row * sSpriteAssetIndexTable[(u8)assetIndex].stride;
    cell = (u16 *)(2 * column + (5 * bank * 4096 + 2 * dStride) + 0x02030000);
    return (*cell & 0xC00) >> 10;
}
