#include "iwram.h"
#include "entity.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern void Entity_CheckProximityAndPlaySound(struct Entity *s, u8 idx, u8 halfW, u8 halfH);

extern const u32 sLevelLayoutPtrs_312DD4[38];
extern const u32 sLevelLayout_312248[];

void LevelEntityBatch_SpawnAndClassify(void)
{
    u8 i;
    struct Entity *base;
    struct Entity *entity;

    for (i = 0; i <= 0x25; i++) {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_312DD4[i], i + 0x33);
    }

    Entity_UpdateMovers(0x33, 0x34);
    Entity_AdvanceAnimFrames(0x33, 0x34);
    Entity_UpdateMovers(0x35, 0x3A);
    Entity_AdvanceAnimFrames(0x35, 0x3A);
    Entity_UpdateMovers(0x3B, 0x58);
    Entity_AdvanceAnimFrames(0x3B, 0x58);

    i = 0x3B;
    base = gEntities;
    for (; i <= 0x58; i++) {
        entity = (struct Entity *)(i * 56 + (s32)base);
        entity->field_06 = 3;

        if (entity->y > 0x89)
            continue;

        /* x is re-read per test (signed for the bounds, unsigned for the
         * windowed range) so agbcc emits the signed load first, matching
         * the baserom's load order. */
        if (entity->x <= 940)
            entity->field_06 = 2;
        if ((u16)((u16)entity->x - 1050) <= 0x3A)
            entity->field_06 = 2;
        if (entity->x > 1193)
            entity->field_06 = 2;
    }
}

void LevelEntity_AnimAndSpawn(void)
{
    u8 i;
    struct Entity *entity;

    for (i = 0; i < 4; i++) {
        entity = (struct Entity *)(i * 56 + 0x1538 + (s32)gEntities);
        if (entity->field_1A == 0) {
            if (entity->field_1B == 1) {
                Entity_CheckProximityAndPlaySound(entity, 8, 2, 2);
            } else if (entity->field_1B == 7) {
                Entity_CheckProximityAndPlaySound(entity, 9, 2, 2);
            }
        } else if (entity->field_1A == 1) {
            if (entity->field_1B == 3) {
                Entity_CheckProximityAndPlaySound(entity, 8, 2, 2);
            } else if (entity->field_1B == 9) {
                Entity_CheckProximityAndPlaySound(entity, 9, 2, 2);
            }
        }
    }

    Entity_WalkCompactRecords(0x61, sLevelLayout_312248, 0x11, &gIwram_6110, 0);
}
