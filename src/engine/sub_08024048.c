#include "iwram.h"
#include "level_layout.h"
#include "types.h"

extern const u32 sLevelLayout_312148[];

void LevelLayout_312148_PlaceEntities(void)
{
    LevelLayout_WalkRecords(20, sLevelLayout_312148, 0x410, 2, 0xa1, 3, 0);
}
