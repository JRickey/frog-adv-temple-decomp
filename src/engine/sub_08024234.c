#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

extern const u32 sLevelLayout_312210[];

void LevelLayout_LoadEntity5F(void)
{
    LevelLayout_WalkRecords(0x5f, sLevelLayout_312210, 16, 25, 0x141, 7, 0);
}
