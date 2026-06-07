#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Mode-handler tail called from Scene06_Tick. Four independent probes
 * over the gIwram_35E0 tile cache + gIwram_3720 counter:
 *
 *   1. Entity_UpdateHitboxWithTile(arg0, arg1, 5) — enqueue with kind=5.
 *   2. If (gIwram_35E0._field_10 & 0x40), look up the tile under the
 *      current entity (gIwram_35E0 _field_18/19/8/A → Tilemap_GetTileClass) and
 *      raise/lower a state flag on the 0x03006110 cluster:
 *        tile == 20 → CtrlFlags_SetBit(0x03006110, 8, 0)
 *        tile == 21 → CtrlFlags_SetBit(0x03006110, 8, 1)
 *   3. Re-probe the tile unconditionally; if (gIwram_35E0._field_10 &
 *      0x10), call Entity_ActivateHitSlot(arg0, arg1, 5, tile).
 *   4. If (gEntities[0].status & 4) == 0 and (u16)(_field_2 - 0xa9)
 *      <= 0xa6 and (s16)_field_4 < ((s16)*(0x03006480+0x36)) << 3,
 *      raise bit 0x800 on gIwram_35E0 via PlayerFlags_Set.
 *
 * Sibling of Scene11_AttractModeMain's case-3 fallthrough block (which uses
 * kind=4 instead of 5 and skips the &0x40/tile-20/21 dispatch) and
 * Entity_UpdateHudState (the &0x10/&0x40 tile-cache idiom).
 *
 * Matching notes (old_agbcc):
 *   - Anonymous-struct cast at 0x03006480 with an `_field_36` at offset
 *     54 forces register-offset ldrsh (`movs r4, #54; ldrsh r0, [r0, r4]`)
 *     and keeps the pool literal at 0x03006480 instead of folding to
 *     0x030064b6. ldrsh has no immediate form in Thumb-1. */

extern void Entity_UpdateHitboxWithTile(void *ent, u32 arg1, u32 kind);
extern void Entity_ActivateHitSlot(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void CtrlFlags_SetBit(u32 base, u32 idx, u32 val);

void Scene12_UpdateTileInteraction(u32 arg0, u32 arg1)
{
    u32 mask;
    struct IwramAt35E0 *p35E0;
    struct Entity *p3720;
    u8 tile;

    Entity_UpdateHitboxWithTile((void *)arg0, arg1, 5);

    {
        struct IwramAt35E0 *p = &gIwram_35E0;
        mask = 0x40;
        mask &= p->_field_10;
        if (mask != 0) {
            tile = (u8)Tilemap_GetTileClass(p->_field_18, p->_field_19, p->_field_8, p->_field_A);
            if (tile == 20)
                CtrlFlags_SetBit(0x03006110, 8, 0);
            if (tile == 21)
                CtrlFlags_SetBit(0x03006110, 8, 1);
        }
    }

    p35E0 = &gIwram_35E0;
    tile = (u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);
    mask = 0x10;
    mask &= p35E0->_field_10;
    if (mask != 0)
        Entity_ActivateHitSlot((void *)arg0, arg1, 5, tile);

    p3720 = gEntities;
    mask = 4;
    mask &= p3720->status;
    if (mask != 0)
        return;

    if ((u16)(p3720->x - 0xa9) > 0xa6)
        return;

    {
        s32 lhs = (s16)p3720->y;
        struct {
            u8 _pad[0x36];
            s16 _field_36;
        } *p6480 = (void *)0x03006480;
        if (lhs >= (p6480->_field_36 << 3))
            return;
    }

    PlayerFlags_Set(p35E0, 0x800);
}
