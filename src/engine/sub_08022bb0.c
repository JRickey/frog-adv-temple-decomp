#include "iwram.h"
#include "sound.h"
#include "entity.h"
#include "types.h"

extern void Pickup_LoadSlotGroup_2(void);
extern void Pickup_LoadSlotGroup_6(void);
extern void Entity_CheckProximityAndPlaySound(struct Entity *s, u8 idx, u8 halfW, u8 halfH);
extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void Entity_DmaLoadSprite(u8 idx);
extern const u8 sLevelLayout_311498[];
extern const u8 sLevelLayoutData_3114C0[];
extern const u32 sLevelLayoutPtrs_3117F0[];
extern const u32 sLevelLayoutPtrs_311910[];
extern const u32 sLevelLayoutPtrs_311A30[];
extern const u32 sLevelLayoutPtrs_3116B8[];

void Pickup_ResetLiveSlots(void)
{
    gIwram_6110.liveCount = 0;
    Pickup_LoadSlotGroup_2();
    Pickup_LoadSlotGroup_6();
}

void EntityGroup_UpdatePickupsA(void)
{
    u8 i;
    struct Entity *entity;

    for (i = 0; i < 4; i++) {
        entity = (struct Entity *)(i * 56 + 0x70 + (s32)gEntities);
        if (entity->field_1A == 0) {
            if (entity->field_1B == 1) {
                Entity_CheckProximityAndPlaySound(entity, 6, 2, 2);
            } else if (entity->field_1B == 7) {
                Entity_CheckProximityAndPlaySound(entity, 7, 2, 2);
            }
        } else if (entity->field_1A == 1) {
            if (entity->field_1B == 3) {
                Entity_CheckProximityAndPlaySound(entity, 6, 2, 2);
            } else if (entity->field_1B == 9) {
                Entity_CheckProximityAndPlaySound(entity, 7, 2, 2);
            }
        }
    }

    Entity_WalkCompactRecords(2, sLevelLayout_311498, 0x11, &gIwram_6110, 0);
}

void EntityGroup_UpdatePickupsB(void)
{
    u8 i;
    struct Entity *entity;

    for (i = 0; i < 6; i++) {
        entity = (struct Entity *)(i * 56 + 0x150 + (s32)gEntities);
        if (entity->field_1A == 2) {
            if (entity->field_1B == 3) {
                Entity_CheckProximityAndPlaySound(entity, 9, 2, 2);
            } else if (entity->field_1B == 8) {
                SoundEntry_Stop(9);
            }
        } else if (entity->field_1A == 3) {
            if (entity->field_1B == 5) {
                Entity_CheckProximityAndPlaySound(entity, 8, 2, 2);
            } else if (entity->field_1B == 10) {
                SoundEntry_Stop(8);
            }
        } else if (entity->field_1A == 4) {
            if (entity->field_1B == 3) {
                Entity_CheckProximityAndPlaySound(entity, 8, 2, 2);
            } else if (entity->field_1B == 10) {
                SoundEntry_Stop(8);
            }
        }
    }

    Entity_WalkCompactRecords(6, sLevelLayoutData_3114C0, 0x12, &gIwram_6110, 0);
}

void SpawnEntityGroup_Slot0C(void)
{
    u8 i;
    u32 slot;
    struct Entity *base;
    struct Entity *baseCopy;
    u32 value;
    u8 *ptr;

    for (i = 0; i < 14; i++) {
        sub_080210A0(i + 12, (const void *)sLevelLayoutPtrs_3116B8[i], 0x400, 20, 0x81, 4, 3, 3);
    }

    i = 0;
    base = gEntities;
    baseCopy = base;
    value = 2;
    for (; i < 6; i++) {
        slot = i;
        slot += 12;
        ((struct Entity *)(slot * 56 + (s32)baseCopy))->field_06 = value;
    }

    ptr = (u8 *)base + 0x57e;
    *ptr = 2;
    Entity_DmaLoadSprite(12);
}

void SpawnEntityGroups_Slot1A_22_2A(void)
{
    u8 i;

    for (i = 0; i < 8; i++) {
        sub_080210A0(i + 26, (const void *)sLevelLayoutPtrs_3117F0[i], 0x420, 21, 0x91, 5, 3, 3);
        sub_080210A0(i + 34, (const void *)sLevelLayoutPtrs_311910[i], 0x400, 22, 0xb1, 5, 3, 3);
        sub_080210A0(i + 42, (const void *)sLevelLayoutPtrs_311A30[i], 0x4000, 1, 0, 0, 3, 3);
    }

    Entity_DmaLoadSprite(26);
    Entity_DmaLoadSprite(34);
}

void EntityGroup_UpdateMovers(void)
{
    u8 i;
    struct Entity *base;
    struct Entity *entity;

    if (gEntities[0].y > 0x168)
        return;

    if (gEntities[0].y <= 0xD7 && gEntities[0].x > 0xA8 && gEntities[0].x <= 0x167)
        SoundEntry_Play(5);
    else
        SoundEntry_Stop(5);

    i = 0;
    base = gEntities;
    for (; i < 8; i++) {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_3117F0[i], i + 26);
        Entity_FollowPath((const void *)sLevelLayoutPtrs_311910[i], i + 34);
        Entity_FollowPath((const void *)sLevelLayoutPtrs_311A30[i], i + 42);

        if (i <= 3) {
            entity = (struct Entity *)((i + 42) * 56 + (s32)base);
            if (entity->field_1A == 1)
                entity->field_06 = 2;
            else
                entity->field_06 = 3;
        } else {
            entity = (struct Entity *)((i + 42) * 56 + (s32)base);
            if (entity->field_1A == 1)
                entity->field_06 = 3;
            else
                entity->field_06 = 2;
        }
    }

    Entity_UpdateMovers(26, 49);
    Entity_AdvanceAnimFrames(26, 49);
}
