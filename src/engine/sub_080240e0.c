#include "iwram.h"
#include "entity.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312DA8[11];

void LevelLayout_InitEntities28(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_312DA8[i], i + 0x28);
        i++;
    } while (i <= 10);

    Entity_UpdateMovers(0x28, 0x29);
    Entity_AdvanceAnimFrames(0x28, 0x29);
    Entity_UpdateMovers(0x2a, 0x31);
    Entity_AdvanceAnimFrames(0x2a, 0x31);
    Entity_UpdateMovers(0x32, 0x32);
    Entity_AdvanceAnimFrames(0x32, 0x32);
}
