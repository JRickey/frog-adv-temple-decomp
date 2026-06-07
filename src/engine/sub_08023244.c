#include "iwram.h"
#include "entity.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_3116B8[14];

void LevelLayout_InitGroup3116B8(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_3116B8[i], i + 12);
        i++;
    } while (i <= 13);

    Entity_UpdateMovers(12, 14);
    Entity_AdvanceAnimFrames(12, 14);
    Entity_UpdateMovers(15, 17);
    Entity_AdvanceAnimFrames(15, 17);
    Entity_UpdateMovers(18, 18);
    Entity_AdvanceAnimFrames(18, 18);
    Entity_UpdateMovers(19, 22);
    Entity_AdvanceAnimFrames(19, 22);
    Entity_UpdateMovers(23, 24);
    Entity_AdvanceAnimFrames(23, 24);
    Entity_UpdateMovers(25, 25);
    Entity_AdvanceAnimFrames(25, 25);
}
