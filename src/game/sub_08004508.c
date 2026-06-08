#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Two-entity variant of the Entity_UpdateHudState / Scene12_UpdateTileInteraction tile-cache probe:
 * enqueues both entity pairs (kind 11 and 16), then — gated on the shared
 * gEntities[0].status & 4 counter — maps the cached tile coords through
 * Tilemap_GetTileClass and, when gIwram_35E0._field_10 & 0x10 is set, re-enqueues
 * both pairs with the resolved tile and pokes TileCacheProbe_HandleTile20.
 *
 * Matching notes (agbcc 2.x):
 *   - The mask local is pinned to r0 for both mask-AND tests so the
 *     `movs #K; ldrh; ands` shape emits with K in r0.
 *   - The r4-pinned `p35E0` local keeps the 0x030035e0
 *     base in r4 across the Tilemap_GetTileClass call so the post-call
 *     `ldrh r4, [r4, #16]` reuses the same base register instead of
 *     reloading the pool literal. */

extern void Entity_UpdateHitboxWithTile(void *ent, u32 arg1, u32 kind);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void TileCacheProbe_HandleTile20(u8 tile);

void Scene20_UpdateParts(u32 arg0, u32 arg1, u32 arg2, u32 arg3)
{
    register u32 mask asm("r0");
    struct IwramAt35E0 *p35E0;
    u16 field;
    struct Entity *p3720;
    u8 tile;

    Entity_UpdateHitboxWithTile((void *)arg0, arg1, 11);
    Entity_UpdateHitboxWithTile((void *)arg2, arg3, 16);

    p3720 = gEntities;
    mask = 4;
    mask &= p3720->status;
    if (mask != 0)
        return;

    p35E0 = &gIwram_35E0;
    tile = (u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    mask = 0x10;
    field = p35E0->_field_10;
    mask &= field;
    if (mask == 0)
        return;

    Entity_ActivateHitSlot((void *)arg0, (void *)arg1, 11, tile);
    Entity_ActivateHitSlot((void *)arg2, (void *)arg3, 16, tile);
    TileCacheProbe_HandleTile20(tile);
}

void TileCacheProbe_Init(u8 *state, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
{
    if ((s8)gIwram_35E0._field_5 <= 1)
        gIwram_6110.scenePhase = 0;
    else
        gIwram_6110.scenePhase = 1;

    if (Scene_EntityTick(state) == 0)
        *state = 7;

    Entity_UpdateHitboxSlots((void *)arg1, (void *)arg2, 11);
    Entity_UpdateHitboxSlots((void *)arg3, (void *)arg4, 16);
}

extern void Game_FrameEnd(void);

void sub_080045E0(void)
{
    Game_FrameEnd();
}
