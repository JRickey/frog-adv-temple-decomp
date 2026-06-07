#include "iwram.h"
#include "entity.h"
#include "types.h"

typedef struct EntitySlot {
    u8 _pad00[0x34];
    u16 flags;
    u8 _pad36[2];
} EntitySlot;

extern void LevelLayout_WalkRecords(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);
extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);

extern const u32 sLevelLayout_317DC4[6];
extern const void *const sLevelLayoutPtrs_317E6C[2];

void sub_0802AAE8(void)
{}

void EntitySlot10_LoadLayout(void)
{
    LevelLayout_WalkRecords(10, sLevelLayout_317DC4, 16, 90, 0xc1, 2, 0);
}

void EntitySlot17_Update(void)
{
    u8 i;
    u16 *flags;
    u32 offset;

    offset = 0xfb;
    flags = (u16 *)((u8 *)gEntities + (offset << 2));
    offset = 8;
    if ((*flags & offset) != 0)
        return;

    i = 0;
    do {
        Entity_FollowPath(sLevelLayoutPtrs_317E6C[i], i + 17);
        i++;
    } while (i <= 1);

    Entity_UpdateMovers(17, 18);
    Entity_AdvanceAnimFrames(17, 18);
}
