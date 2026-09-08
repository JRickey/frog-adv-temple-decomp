#include "entity.h"
#include "level_layout.h"
#include "level_layout_data.h"
#include "iwram.h"
#include "types.h"

void sub_080247AC(void)
{
    LevelLayout_WalkRecords(2, &sLevelLayout_312EEC.header, 0x10, 0x4b, 0x41, 1, 0);
}

void sub_080247D4(void)
{
    Entity_WalkCompactRecords(2, &sLevelLayout_312EEC.header, 0x11, &gIwram_6110, 0);
}

void sub_080247F8(void)
{
    LevelLayout_WalkRecords(0x20, &sLevelLayout_312FE4.header, 0x10, 4, 0x61, 2, 0);
}

void sub_08024820(void)
{
    Entity_WalkCompactRecords(0x20, &sLevelLayout_312FE4.header, 4, &gIwram_6110, 0);
}

void sub_08024844(void)
{
    LevelLayout_WalkRecords(0x25, &sLevelLayout_313014.header, 0x10, 2, 0x71, 3, 0);
}

void sub_0802486C(void)
{
    Entity_WalkCompactRecords(0x25, &sLevelLayout_313014.header, 2, &gIwram_6110, 0);
}
