#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_316F64[48];
extern const u32 sLevelLayout_317024[12];
extern const u32 sLevelLayout_317054[10];
extern const u32 sLevelLayout_31707C[22];

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
