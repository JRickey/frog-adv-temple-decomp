#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_312210[];

void LevelLayout_LoadEntity5F(void)
{
    LevelLayout_WalkRecords(0x5f, sLevelLayout_312210, 16, 25, 0x141, 7, 0);
}
