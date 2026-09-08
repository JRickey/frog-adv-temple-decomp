#include "iwram.h"
#include "entity.h"
#include "types.h"

extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_311C80[12];

void LevelLayout_InitGroup311C80(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_311C80[i], i + 0x32);
        i++;
    } while (i <= 11);

    Entity_UpdateMovers(0x32, 0x34);
    Entity_AdvanceAnimFrames(0x32, 0x34);
    Entity_UpdateMovers(0x35, 0x36);
    Entity_AdvanceAnimFrames(0x35, 0x36);
    Entity_UpdateMovers(0x37, 0x3b);
    Entity_AdvanceAnimFrames(0x37, 0x3b);
    Entity_UpdateMovers(0x3c, 0x3d);
    Entity_AdvanceAnimFrames(0x3c, 0x3d);
}
