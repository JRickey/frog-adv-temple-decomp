#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Field-store helper on the per-room packed-halfword grid at EWRAM
 * 0x02030000. The matching read accessor is Tilemap_GetTileClass, which pulls
 * (*cell & 0x3F0) >> 4 from the same cell; this writer clears that 6-bit
 * field and ORs in (e << 4). The grid stride (entry_descriptor[+4]) comes
 * from sSpriteAssetIndexTable at 0x08306444 (see src/data/sprite_dispatch.c).
 *
 * Matching notes (agbcc 2.x, built under old_agbcc like the sister
 * accessors):
 *   - sSpriteAssetIndexTable is NON-const so each statement re-reads the
 *     stride from memory; that defeats agbcc's CSE-fold of the two identical
 *     address expressions and forces the baserom's pin of the 0x02030000
 *     base in r8 across both read-modify-writes (a const table folds the two
 *     stores into one and never spills r8).
 *   - The address is written inline twice (no cached `cell` pointer) so each
 *     store recomputes its own offset, matching baserom's two-store schedule.
 *   - Term order is 2*dStride first, then 5*b*4096, then 2*c last: it pins
 *     the `lsls #1` of the stride term and the `c` sign-extend to baserom's
 *     instruction positions. */

extern struct SpriteAssetIndexEntry sSpriteAssetIndexTable[];

void SpriteGrid_SetCellFlags(u8 a, u8 b, s16 c, s16 d, u8 e)
{
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) &= 0xFC0F;
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) |= (u8)e << 4;
}

void BgMap_WriteTileAttr(u8 a, u8 b, s16 c, s16 d, u8 e)
{
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) &= 0xFFF0;
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) |= (u8)e;
}

void SpriteGrid_SetBit14(u8 a, u8 b, s16 c, s16 d, u8 e)
{
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) &= 0xBFFF;
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) |= (u8)e << 14;
}

void SpriteGrid_SetBits13_12(u8 a, u8 b, s16 c, s16 d, u8 e)
{
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) &= 0xCFFF;
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) |= (u8)e << 12;
}

void SpriteGrid_SetBits11_10(u8 a, u8 b, s16 c, s16 d, u8 e)
{
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) &= 0xF3FF;
    *(u16 *)(2 * (d * sSpriteAssetIndexTable[(u8)a].stride) + 5 * b * 4096 + 2 * c + 0x02030000) |= (u8)e << 4;
}
