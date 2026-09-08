#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_312228[8];

void LevelLayout_312228_PlaceEntities(void)
{
    LevelLayout_WalkRecords(0x74, sLevelLayout_312228, 16, 4, 0x341, 13, 0);
}
