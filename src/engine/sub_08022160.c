#include "iwram.h"
#include "types.h"

extern void Entity_FollowPath(const void *a0, s32 slot);
extern void Entity_UpdateMovers(s32 a0, s32 a1);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern const u32 sLevelLayoutDispatch_3112A8[8];

void SpawnEntitiesIfScrolled(void)
{
    struct Entity *elt;
    u8 i;
    struct Entity *base;

    if (gEntities[0].y <= 0x2B7)
        return;

    i = 0;
    base = gEntities;
    do {
        s32 slot = i + 0x27;

        ModeControl_SetBit(&gIwram_6110, slot);

        /* index-first cast: forces `adds r5, r0(offset), r1(base)` */
        elt = (struct Entity *)(slot * 56 + (s32)base);
        elt->field_17 = 3;
        Entity_FollowPath((const void *)sLevelLayoutDispatch_3112A8[i], slot);

        if (elt->y > 0x37F)
            elt->field_17 = 2;

        i++;
    } while (i <= 7);

    Entity_UpdateMovers(0x27, 0x29);
    Entity_UpdateMovers(0x2A, 0x2C);
    Entity_AdvanceAnimFrames(0x27, 0x2C);
    Entity_UpdateMovers(0x2D, 0x2E);
    Entity_AdvanceAnimFrames(0x2D, 0x2E);
}
