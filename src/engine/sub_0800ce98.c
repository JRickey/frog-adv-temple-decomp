#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Initializer for the per-room packed-halfword grid at EWRAM 0x02030000
 * (read by sister functions sub_0800CD88 / sub_0800CDCC / sub_0800CE10 /
 * sub_0800CE54). Copies sSpriteAssetIndexTable[a].dataPtr into the room
 * slot at 0x02030000 + b*0x5000 via BIOS CpuSet (SWI 11, sub_0802D554).
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

extern u32 sub_0802D554(const void *src, void *dst, u32 count);

u32 sub_0800CE98(u8 a, u8 b)
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
    return sub_0802D554(src, dst, stride * field5);
}

/* --- sub_0800CED0: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct Rect2 {
    u16 _field_0;
    s16 _field_2;
    s16 _field_4;
};

/* old_agbcc TU (sister grid functions all build under old_agbcc). */
u32 sub_0800CED0(struct Rect2 *s, s32 a, s32 b, s16 c, s16 e)
{
    register s32 himask asm("r8");
    register s32 ee asm("r9"); /* s32 (not s16) — s16 adds a spurious (u16) ext */
    s32 va;
    s32 vb;
    s16 x0, y0, w, h;
    s16 rx, ry;
    u32 result;

    ee = e;
    va = (u16)(a - ee);
    himask = 0xffff0000;
    va = (a & himask) | va;
    if ((s16)va < 0)
        va = (va & himask);
    va = (va & 0x0000ffff) | (((s16)(va >> 16) - c) << 16);
    if ((s16)(va >> 16) < 0)
        va = (va & 0x0000ffff);

    vb = (b & himask) | (u16)(b + 2 * c);
    vb = (vb & 0x0000ffff) | (((s16)(vb >> 16) + 2 * ee) << 16);

    x0 = (s16)(va >> 16);
    y0 = (s16)va;
    w = (s16)vb;
    h = (s16)(vb >> 16);

    rx = s->_field_2;
    ry = s->_field_4;

    result = 0;
    if (rx < x0)
        return result;
    if (rx > x0 + w)
        return result;
    if (ry < y0)
        return result;
    if (ry > y0 + h)
        return result;
    result = 1;
    return result;
}
#endif /* NON_MATCHING */
