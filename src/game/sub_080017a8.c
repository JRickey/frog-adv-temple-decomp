#include "entity.h"
#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void EntityDispatch_RunFrame(void);
extern void Game_FrameEnd(void);

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Entity_UpdateHitboxWithTile(void *ent, u32 arg1, u32 kind);
extern void Entity_ActivateHitSlot(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);

/* Mode-setup entry, sibling of Scene06_Init: installs config table
 * 0x082f9a1c into the gGameStuff_6110 cluster via the shared 6-arg
 * setup helper, then primes the post-setup state via
 * SpriteAsset_LoadSheet(5, 0) and EntityDispatch_RunFrame(). */
void Scene05_Init(void)
{
    ModeControl_Init(&gIwram_6110, 0x80, 5, (const void *)0x082f9a1c, 1, 3);
    SpriteAsset_LoadSheet(5, 0);
    EntityDispatch_RunFrame();
}

/* Single-entity-pair (kind 4) variant of the Scene20_UpdateParts tile-cache probe,
 * preceded by the five per-frame setup calls and trailed by the
 * gGameStuff._unk14 frame counter bump. Enqueues the pair, then — gated on
 * gEntities[0].status & 4 — maps the cached tile coords through Tilemap_GetTileClass
 * and re-enqueues with the resolved tile when gIwram_35E0._field_10 & 0x10. */
void Scene05_Tick(u32 arg0, u32 arg1)
{
    register u32 mask asm("r0");
    struct IwramAt35E0 *p35E0;
    u16 field;
    struct Entity *p3720;
    u8 tile;

    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();

    Entity_UpdateHitboxWithTile((void *)arg0, arg1, 4);

    p3720 = gEntities;
    mask = 4;
    mask &= p3720->status;
    if (mask != 0)
        goto done;

    p35E0 = &gIwram_35E0;
    tile = (u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    mask = 0x10;
    field = p35E0->_field_10;
    mask &= field;
    if (mask == 0)
        goto done;

    Entity_ActivateHitSlot((void *)arg0, arg1, 4, tile);

done:
    gGameStuff._unk14++;
}

void Scene05_StateTransition(u8 *state, u32 a, u32 b)
{
    if (Scene_EntityTick(state) == 0) {
        *state = 7;
    }
    Entity_UpdateHitboxSlots((void *)a, (void *)b, 4);
    if (gIwram_35E0._field_5 <= 1) {
        gIwram_6110.scenePhase = 0;
        gIwram_6110.selector5Flags = 0;
    } else {
        gIwram_6110.scenePhase = 5;
    }
}

/* Thin forwarder to Game_FrameEnd — same shape as Scene06_Exit
 * (push lr; bl Game_FrameEnd; pop r0; bx r0). */
void Scene05_Exit(void)
{
    Game_FrameEnd();
}

/* Like Scene05_Tick but without the five per-frame setup calls and
 * without the gGameStuff._unk14 bump — bare tile-cache probe. */
void Scene05_EntityDispatch(u32 arg0, u32 arg1)
{
    register u32 mask asm("r0");
    struct IwramAt35E0 *p35E0;
    u16 field;
    struct Entity *p3720;
    u8 tile;

    Entity_UpdateHitboxWithTile((void *)arg0, arg1, 4);

    p3720 = gEntities;
    mask = 4;
    mask &= p3720->status;
    if (mask != 0)
        goto done;

    p35E0 = &gIwram_35E0;
    tile = (u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    mask = 0x10;
    field = p35E0->_field_10;
    mask &= field;
    if (mask == 0)
        goto done;

    Entity_ActivateHitSlot((void *)arg0, arg1, 4, tile);

done:;
}
