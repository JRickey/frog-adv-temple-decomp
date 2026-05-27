#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct SpriteAssetIndexEntry {
    u32 dataPtr;
    u8 stride;
    u8 _field_5;
    u8 _field_6;
    u8 _field_7;
};

extern const struct SpriteAssetIndexEntry sSpriteAssetIndexTable[];

u32 sub_0800CE10(u8 a, u8 b, s16 c, s16 d)
{
    s32 dStride;
    u16 *cell;

    dStride = d * sSpriteAssetIndexTable[(u8)a].stride;
    cell = (u16 *)(2 * c + (5 * b * 4096 + 2 * dStride) + 0x02030000);
    return (*cell & 0x3000) >> 12;
}
