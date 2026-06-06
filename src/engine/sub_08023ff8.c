#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

extern const u32 sLevelLayout_312228[8];

void LevelLayout_312228_PlaceEntities(void)
{
    LevelLayout_WalkRecords(0x74, sLevelLayout_312228, 16, 4, 0x341, 13, 0);
}
