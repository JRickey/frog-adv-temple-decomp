#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Input/state gate that fans out into three independent subsystem pokes:
 *
 *   1. If gEntities[0].status & 4 is set, raise a single flag via
 *      ModeControl_ClearBit(0x03006110, 8, 1) and skip the rest of the function.
 *   2. Otherwise call the predicate ModeControl_GetFlag(0x03006110, 5, 15); when
 *      it returns nonzero, OR bit 8 into the halfword at 0x03006110[+0x2e].
 *   3. If gIwram_35E0._field_10 & 0x10 is set, sample the cached tile
 *      coords (gIwram_35E0._field_18/19/8/A), run Tilemap_GetTileClass to map
 *      them to a tile id, and hand the (u8)tile to FrogPad_CheckTile.
 *
 * Same gEntities[0].status & 4 gate appears in Scene08_UpdatePlayerEntity /
 * Scene09_UpdatePlayerTile — this function looks like another per-entity probe in
 * the same family, with a lighter (single Tilemap_GetTileClass / FrogPad_CheckTile)
 * tail instead of the &0x10 dispatch + bit-test guard those siblings
 * use.
 *
 * Matching notes (agbcc 2.x):
 *   - The mask local is pinned to r0 so
 *     the two `mask = K; mask &= field` blocks emit
 *     `movs r0, #K; ldrh rN, [base, #o]; ands r0, rN` (the mask-first /
 *     base-overwrite shape — see docs/codegen-notes.md "Mask-before-
 *     field-load on a single-use struct base").
 *   - The field local is pinned to r4 on the second test (block 3), forcing
 *     the field load into r4 (the just-freed second-pool base register)
 *     instead of r1 (which agbcc would otherwise pick).
 *   - The OR-and-write in block 2 is split into three statements
 *     (`t = 8; t |= load; store = t;`) to defeat the `ldrh ; orrs ; strh`
 *     fold and emit baserom's `movs #8 ; ldrh ; orrs ; strh` shape.
 *   - `base6110` as a local `u8 *` keeps r4 anchored to 0x03006110 across
 *     the BL to ModeControl_GetFlag so the post-call ldrh/strh reuse the same
 *     base register at +0x2e instead of materializing a fresh
 *     0x0300613e pool entry. */

extern void ModeControl_ClearBit(u32 base, u32 idx, u32 val);
extern u32 ModeControl_GetFlag(u32 base, u32 a, u32 b);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void FrogPad_CheckTile(u8 tile);

void Entity_UpdateHudState(void)
{
    register u32 mask asm("r0");
    register u16 field asm("r4");
    struct Entity *p3720 = gEntities;
    struct IwramAt35E0 *p35E0;
    u8 *base6110;
    u8 tile;

    mask = 4;
    mask &= p3720->status;
    if (mask != 0) {
        ModeControl_ClearBit(0x03006110, 8, 1);
        return;
    }

    base6110 = (u8 *)0x03006110;
    if ((u8)ModeControl_GetFlag((u32)base6110, 5, 15) != 0) {
        u16 t = 8;
        t |= *(u16 *)(base6110 + 0x2e);
        *(u16 *)(base6110 + 0x2e) = t;
    }

    p35E0 = &gIwram_35E0;
    mask = 0x10;
    field = p35E0->_field_10;
    mask &= field;
    if (mask == 0)
        return;

    tile = (u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);
    FrogPad_CheckTile(tile);
}
