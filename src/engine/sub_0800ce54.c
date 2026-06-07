#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const struct SpriteAssetIndexEntry sSpriteAssetIndexTable[];

u32 TileCell_GetPropertyB(u8 a, u8 b, s16 c, s16 d)
{
    s32 dStride;
    u16 *cell;

    dStride = d * sSpriteAssetIndexTable[(u8)a].stride;
    cell = (u16 *)(2 * c + (5 * b * 4096 + 2 * dStride) + 0x02030000);
    return (*cell & 0xC00) >> 10;
}
