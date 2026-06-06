#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Initializer for the per-room packed-halfword grid at EWRAM 0x02030000
 * (read by sister functions Tilemap_GetTileClass / SpriteAsset_GetCellFlag / SpriteAsset_GetTileAttr /
 * TileCell_GetPropertyB). Copies sSpriteAssetIndexTable[a].dataPtr into the room
 * slot at 0x02030000 + b*0x5000 via BIOS CpuSet (SWI 11, Bios_CpuSet).
 *
 * Match notes: register-pinned r4/r5 for stride/_field_5 (agbcc otherwise
 * inlines the reads and skips the push); separate `table` local anchors
 * the pool load before the `(u8)a` shift-extract; u32 return type pins
 * the epilogue's pop choice to `{r1}; bx r1` (sister-fn idiom). */

struct SpriteAssetIndexEntry {
    u32 dataPtr;
    u8 stride;
    u8 _field_5;
    u8 _field_6;
    u8 _field_7;
};

extern const struct SpriteAssetIndexEntry sSpriteAssetIndexTable[];

extern u32 Bios_CpuSet(const void *src, void *dst, u32 count);

u32 SpriteAsset_LoadSheet(u8 a, u8 b)
{
    const struct SpriteAssetIndexEntry *table = sSpriteAssetIndexTable;
    const struct SpriteAssetIndexEntry *entry;
    register u8 stride asm("r4");
    register u8 field5 asm("r5");
    const void *src;
    void *dst;
    entry = &table[(u8)a];
    src = (const void *)entry->dataPtr;
    dst = (void *)(0x02030000 + (u8)b * 0x5000);
    stride = entry->stride;
    field5 = entry->_field_5;
    return Bios_CpuSet(src, dst, stride * field5);
}
