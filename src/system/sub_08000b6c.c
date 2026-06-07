#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Entity_UpdateHitboxWithTile(void *ent, u32 arg1, u32 kind);
extern void Entity_ActivateHitSlot(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern u32 SpriteAsset_GetCellFlag(u8 col, u8 row, s32 tileX, s32 tileY);
extern void IwramFlags_Clear(void *p, u16 mask);

void Scene08_UpdatePlayerEntity(void *ent, u32 arg1)
{
    u8 *gp3720;
    u8 tile;

    Entity_UpdateHitboxWithTile(ent, arg1, 18);

    gp3720 = (u8 *)gEntities;
    if ((*(u16 *)(gp3720 + 0x34) & 4) != 0)
        return;

    tile = (u8)Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                    gIwram_35E0._field_A);

    if ((gIwram_35E0._field_10 & 0x10) != 0)
        Entity_ActivateHitSlot(ent, arg1, 18, tile);

    if ((gIwram_35E0._field_10 & 0x40) != 0) {
        if ((u8)SpriteAsset_GetCellFlag(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                        gIwram_35E0._field_A) != 0) {
            if (gIwram_35E0._field_18 == 0) {
                gIwram_35E0._field_18 = 1;
                gIwram_35E0._field_19 = 1;
                gp3720[6] = 2;
                gp3720[0x17] = 2;
            } else {
                gIwram_35E0._field_18 = 0;
                gIwram_35E0._field_19 = 0;
                gp3720[6] = 3;
                gp3720[0x17] = 3;
            }
        }
    }

    if ((gGameStuff._unk10 & 1) != 0)
        return;

    {
        u8 *entityBase;
        entityBase = (u8 *)gEntities;
        if (*(u16 *)(entityBase + 2) > 408) {
            PlayerFlags_Set(&gIwram_35E0, 0x800);
        }

        if (tile != 7)
            return;

        if (*(s16 *)(entityBase + 4) > 1000) {
            if ((u16)(*(u16 *)(entityBase + 2) - 0xaa) <= 24) {
                IwramFlags_Clear(&gIwram_35E0, 2);
                *(u16 *)(entityBase + 2) = *(u16 *)(entityBase + 2) - 1;
            }
        }
    }

    {
        u8 *entityBase;
        s32 delta;
        entityBase = (u8 *)gEntities;
        delta = -0x104;
        if ((u16)(*(u16 *)(entityBase + 2) + delta) > 24)
            return;
        IwramFlags_Clear(&gIwram_35E0, 2);
        *(u16 *)(entityBase + 2) = *(u16 *)(entityBase + 2) + 1;
    }
}
