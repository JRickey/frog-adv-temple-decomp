#include "game.h"
#include "entity.h"
#include "iwram.h"
#include "sound.h"
#include "sprite_grid.h"
#include "types.h"

extern u8 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void PickEntitySpawnPos(void);
extern void BlitEntityTileFrame0(void);
extern void BlitEntityTileFrame1(void);
extern void BlitEntityTileFrame2(void);
extern void TileCollect_OnStep(u8 tile);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s16 x, s16 y);
extern void EntitySlot17_Init(void);
extern void LoadScreenTilemap_188EDC(void);

void Entity_CollisionProbe(CollisionSlot *slots, u64 *mask)
{
    u8 tile;

    if (ModeControl_GetFlag(&gIwram_6110, 8, 5)) {
        gEntities[12].state = 3;
        gEntities[12].status |= 2;
        ModeControl_ClearBit(&gIwram_6110, 8, 5);
    }

    if (ModeControl_GetFlag(&gIwram_6110, 8, 1)) {
        if (gIwram_6110.gateByte == 1) {
            gEntities[17].status |= 8;
            gEntities[18].status |= 8;
        }
        PickEntitySpawnPos();
        BlitEntityTileFrame0();
        Sound_Play(0x23);
        SpriteGrid_SetCellFlags(gIwram_35E0._field_18, gIwram_35E0._field_19, gEntities[30].x, gEntities[30].y, 20);
        gEntities[12].state = 1;
        gEntities[12].status |= 2;
        CtrlFlags_SetBit(&gIwram_6110, 8, 3);
        gEntities[30].spawnTick = gGameStuff._unk00;
        ModeControl_ClearBit(&gIwram_6110, 8, 1);
    }

    if (ModeControl_GetFlag(&gIwram_6110, 8, 2)) {
        BlitEntityTileFrame2();
        SpriteGrid_SetCellFlags(gIwram_35E0._field_18, gIwram_35E0._field_19, gEntities[30].x, gEntities[30].y, 4);
        gEntities[30].spawnTick = gGameStuff._unk00;
        CtrlFlags_SetBit(&gIwram_6110, 8, 6);
        ModeControl_ClearBit(&gIwram_6110, 8, 2);
        ModeControl_ClearBit(&gIwram_6110, 8, 3);
    }

    if (ModeControl_GetFlag(&gIwram_6110, 8, 3)) {
        if (gGameStuff._unk00 - gEntities[30].spawnTick > 240) {
            CtrlFlags_SetBit(&gIwram_6110, 8, 2);
            Sound_Play(0x74);
            ModeControl_ClearBit(&gIwram_6110, 8, 3);
        } else if (gIwram_35E0._field_10 & 0x10) {
            tile = Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                        gIwram_35E0._field_A);

            TileCollect_OnStep(tile);
        }
    }

    if (ModeControl_GetFlag(&gIwram_6110, 8, 6) && gGameStuff._unk00 - gEntities[30].spawnTick > 240) {
        CtrlFlags_SetBit(&gIwram_6110, 8, 0);
        ModeControl_ClearBit(&gIwram_6110, 8, 6);
    }

    if (ModeControl_GetFlag(&gIwram_6110, 8, 4)) {
        BlitEntityTileFrame1();
        SpriteGrid_SetCellFlags(gIwram_35E0._field_18, gIwram_35E0._field_19, gEntities[30].x, gEntities[30].y, 4);
        gEntities[12].state = 2;
        gEntities[12].status |= 2;
        gEntities[10].state = 3;
        gEntities[10].status |= 2;
        gEntities[11].state = 4;
        gEntities[11].status |= 2;
        gIwram_6110.gateByte++;
        gEntities[30].spawnTick = gGameStuff._unk00;
        CtrlFlags_SetBit(&gIwram_6110, 8, 6);
        ModeControl_ClearBit(&gIwram_6110, 8, 4);
        ModeControl_ClearBit(&gIwram_6110, 8, 7);
    }

    if (gIwram_6110.spawnMask == 2) {
        Entity_UpdateHitboxWithTile(slots, mask, 28);
        if (gIwram_6110.spawnMask == 2 && ModeControl_GetFlag(&gIwram_6110, 8, 7) && (gIwram_35E0._field_10 & 0x10)) {
            tile = Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                        gIwram_35E0._field_A);

            Entity_ActivateHitSlot(slots, mask, 28, tile);
        }
    }

    if (ModeControl_GetFlag(&gIwram_6110, 8, 0)) {
        gIwram_6110.spawnMask = gIwram_6110.gateByte;
        if (gIwram_6110.spawnMask == 1)
            EntitySlot17_Init();
        if (gIwram_6110.gateByte == 2) {
            Entity_UpdateHitboxSlots(slots, mask, 28);
            LoadScreenTilemap_188EDC();
        }
    }
}
