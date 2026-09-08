#include "level_layout.h"
#include "entity_spawn.h"
#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern const u32 sLevelLayout_316F64[48];
extern const u32 sLevelLayout_317024[12];
extern const u32 sLevelLayout_317054[10];
extern const u32 sLevelLayout_31707C[22];
extern void Entity_AdvanceAnimFrames(s32 start, s32 end);

void sub_080295AC(void)
{
    LevelLayout_WalkRecords(2, sLevelLayout_316F64, 16, 2, 0x41, 1, 0);
}

void sub_080295D4(void)
{
    Entity_WalkCompactRecords(2, sLevelLayout_316F64, 2, &gIwram_6110, 0);
}

void sub_080295F8(void)
{
    LevelLayout_WalkRecords(25, sLevelLayout_317024, 16, 4, 0x51, 2, 0);
}

void sub_08029620(void)
{
    Entity_WalkCompactRecords(25, sLevelLayout_317024, 4, &gIwram_6110, 0);
}

void sub_08029644(void)
{
    LevelLayout_WalkRecords(30, sLevelLayout_317054, 16, 11, 0x61, 3, 0);
}

void sub_0802966C(void)
{
    Entity_WalkCompactRecords(30, sLevelLayout_317054, 11, &gIwram_6110, 0);
}

void sub_08029690(void)
{
    LevelLayout_WalkRecords(40, sLevelLayout_31707C, 16, 0x41, 0x71, 4, 0);
}

extern const u32 sLevelLayoutPtrs[66];
extern const u32 sLevelLayoutPtrs_317A60[14];

enum { GROUP317A4C_COUNT = 5, GROUP317A4C_FIRST_SLOT = 50, GROUP317A4C_KIND = 0x47, GROUP317A4C_SPAWN_FLAGS = 16 };

/* Initialize five consecutive slots from the first layout-pointer window. */
void LevelLayout_SpawnGroup317A4C(void)
{
    u8 i = 0;

    do {
        Entity_InitSlotFromRecord(i + GROUP317A4C_FIRST_SLOT, (const SpawnRecord *)sLevelLayoutPtrs[i],
                                  GROUP317A4C_SPAWN_FLAGS, GROUP317A4C_KIND, ((i % GROUP317A4C_COUNT) << 2) + 0x111, 5,
                                  3, 3);
        i++;
    } while (i < GROUP317A4C_COUNT);
}

void LevelLayout_UpdateGroup317A60(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_317A60[i], i + 56);
        i++;
    } while (i <= 13);

    Entity_UpdateMovers(56, 69);
    Entity_AdvanceAnimFrames(56, 69);
}
