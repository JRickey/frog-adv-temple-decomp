#include "iwram.h"
#include "level_layout.h"
#include "entity.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void Entity_DmaLoadSprite(u8 idx);
extern const u32 sLevelLayoutPtrs_310DD4[8];
extern const u32 sLevelLayout_310C2C[6];
extern const u32 sLevelLayoutPtrs_311074[14];
extern const u32 sLevelLayoutPtrs_31118C[7];
extern const u32 sLevelLayout_310B84[42];

void UpdateZone_Slots36to3D(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_310DD4[i], i + 0x36);
        i++;
    } while (i <= 7);

    Entity_UpdateMovers(0x36, 0x3d);
    Entity_AdvanceAnimFrames(0x36, 0x3d);
}

void StreamInit_Slot2F(void)
{
    LevelLayout_WalkRecords(0x2f, sLevelLayout_310C2C, 0, 0xb, 0xd1, 7, 0);
}

void SpawnZone_Slot2F(void)
{
    Entity_WalkCompactRecords(0x2f, sLevelLayout_310C2C, 0xb, &gIwram_6110, 0);
}

void UpdateZone_Slots19to26(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_311074[i], i + 25);
        i++;
    } while (i <= 13);

    Entity_UpdateMovers(25, 38);
    Entity_AdvanceAnimFrames(25, 38);
}

void StreamInit_Slots3Eto44(void)
{
    u8 i;

    i = 0;
    do {
        Entity_InitSlotFromRecord(i + 0x3e, (const void *)sLevelLayoutPtrs_31118C[i], 0x400, 14, 0x165, 9, 3, 3);
        i++;
    } while (i <= 6);

    Entity_DmaLoadSprite(0x3e);
}

void StreamInit_Slot05(void)
{
    LevelLayout_WalkRecords(5, sLevelLayout_310B84, 0, 2, 0x51, 2, 0);
}
