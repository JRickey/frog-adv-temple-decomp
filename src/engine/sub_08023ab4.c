#include "iwram.h"
#include "types.h"

extern void Entity_CheckProximityAndPlaySound(struct Entity *s, u8 idx, u8 halfW, u8 halfH);
extern void Entity_FollowPath(const void *a0, s32 slot);
extern void ModeControl_SetBit(void *p, s32 idx);
extern void Entity_UpdateMovers(s32 a0, s32 a1);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312D80[10];

void LevelEntities_SpawnGroup10(void)
{
    u8 i;
    struct Entity *entity;
    s16 distFrom827;
    s16 distFrom851;
    s16 dist;

    for (i = 0; i <= 9; i++) {
        entity = (struct Entity *)(i * 56 + (s32)&gEntities[10]);

        /* dist temp is assigned into distFrom827 as a separate step: the
         * baserom keeps the -827 constant in distFrom827's register through
         * both arms, so the abs result is computed in a scratch reg and then
         * copied. distFrom851 has its constant in a temp, so it stores in
         * place with no copy. */
        if ((s16)entity->y - 827 >= 0)
            dist = entity->y - 827;
        else
            dist = 827 - entity->y;
        distFrom827 = dist;

        if ((s16)entity->y - 851 >= 0)
            distFrom851 = entity->y - 851;
        else
            distFrom851 = 851 - entity->y;

        if (entity->x == 899) {
            Entity_CheckProximityAndPlaySound(entity, 7, 10, 3);
        } else if (distFrom827 <= 4) {
            Entity_CheckProximityAndPlaySound(entity, 7, 5, 10);
        } else if (distFrom851 <= 4 && i == 5) {
            Entity_CheckProximityAndPlaySound(entity, 7, 3, 10);
        }

        Entity_FollowPath((const void *)sLevelLayoutPtrs_312D80[i], i + 10);
        ModeControl_SetBit(&gIwram_6110, i + 10);
    }

    Entity_UpdateMovers(10, 14);
    Entity_AdvanceAnimFrames(10, 14);
    Entity_UpdateMovers(15, 15);
    Entity_AdvanceAnimFrames(15, 15);
    Entity_UpdateMovers(16, 19);
    Entity_AdvanceAnimFrames(16, 19);
}
