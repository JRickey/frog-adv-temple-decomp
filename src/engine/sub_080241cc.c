#include "iwram.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_UpdateMovers(s32 a0, s32 a1);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312E6C[6];

void LevelLayout_InitEntities59(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_312E6C[i], i + 0x59);
        i++;
    } while (i <= 5);

    Entity_UpdateMovers(0x59, 0x5a);
    Entity_AdvanceAnimFrames(0x59, 0x5a);
    Entity_UpdateMovers(0x5b, 0x5b);
    Entity_AdvanceAnimFrames(0x5b, 0x5b);
    Entity_UpdateMovers(0x5c, 0x5d);
    Entity_AdvanceAnimFrames(0x5c, 0x5d);
    Entity_UpdateMovers(0x5e, 0x5e);
    Entity_AdvanceAnimFrames(0x5e, 0x5e);
}
