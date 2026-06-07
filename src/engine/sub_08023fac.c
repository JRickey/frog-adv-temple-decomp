#include "iwram.h"
#include "entity.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312D60[8];

void LevelLayout_312D60_UpdateEntities(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_312D60[i], i + 2);
        i++;
    } while (i <= 7);

    ModeControl_SetBit(&gIwram_6110, 2);
    ModeControl_SetBit(&gIwram_6110, 3);
    Entity_UpdateMovers(2, 9);
    Entity_AdvanceAnimFrames(2, 9);
}
