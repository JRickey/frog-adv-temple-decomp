#include "iwram.h"
#include "level_layout.h"
#include "types.h"

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
