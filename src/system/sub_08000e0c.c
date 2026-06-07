#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Entity_UpdateHitboxWithTile(void *ent, u32 arg1, u32 kind);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void Frog_ProcessTileContact(u8 tile);

void Scene09_UpdatePlayerTile(void *ent, u32 arg1)
{
    u8 tile;
    register u32 coord asm("r2");
    u32 coordAlias;
    u32 firstCoord;

    Entity_UpdateHitboxWithTile(ent, arg1, 3);

    if ((gEntities[0].status & 4) != 0)
        return;

    tile = (u8)Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                    gIwram_35E0._field_A);

    if ((gIwram_35E0._field_10 & 0x10) != 0) {
        Frog_ProcessTileContact(tile);
        Entity_ActivateHitSlot(ent, (void *)arg1, 3, tile);
    }

    if ((u8)IsFlagMaskSet(&gIwram_35E0, 0x40) == 0)
        return;

    coord = *(u32 *)((u8 *)&gIwram_35E0 + 8);
    firstCoord = 0x001c0006;
    coordAlias = coord;
    if (coordAlias == firstCoord)
        gEntities[0].field_06 = 2;
    if (coordAlias == 0x001c0007)
        gEntities[0].field_06 = 3;
    if (coordAlias == 0x001c000d)
        gEntities[0].field_06 = 3;
    if (coord == 0x001c000e)
        gEntities[0].field_06 = 2;
}
