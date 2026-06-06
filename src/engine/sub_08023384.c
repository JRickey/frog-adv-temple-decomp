#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_311D38[8];

void StreamInit_Slot4E(void)
{
    LevelLayout_WalkRecords(0x4e, sLevelLayout_311D38, 0, 11, 0x161, 10, 0);
}
