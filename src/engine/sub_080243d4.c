#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);

extern const u32 sLevelLayout_3121F0[];

void InitEntitySlot71WithDifficulty(void)
{
    u8 i;

    LevelLayout_WalkRecords(0x71, sLevelLayout_3121F0, 0, 0x1f, 0x2e1, 12, 0);

    i = 0;
    do {
        if (gIwram_35E0._field_5 > 1) {
            gEntities[0x71 + i].state = 3;
        } else {
            gEntities[0x71 + i].state = 0;
        }
        i++;
    } while (i <= 2);
}
