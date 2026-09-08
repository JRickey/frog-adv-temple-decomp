#include "entity.h"
#include "level_layout.h"
#include "level_layout_data.h"
#include "iwram.h"

void sub_08025180(void)
{
    LevelLayout_WalkRecords(2, &sLevelLayout_3133D0.header, 0x10, 2, 0x41, 1, 0);
}

void sub_080251A8(void)
{
    Entity_WalkCompactRecords(2, &sLevelLayout_3133D0.header, 2, &gIwram_6110, 0);
}

void sub_080251CC(void)
{
    LevelLayout_WalkRecords(0x21, &sLevelLayout_3134D0.header, 0x10, 0xB, 0x51, 2, 0);
}

void sub_080251F4(void)
{
    Entity_WalkCompactRecords(0x21, &sLevelLayout_3134D0.header, 0xB, &gIwram_6110, 0);
}

void sub_08025218(void)
{
    LevelLayout_WalkRecords(0x27, &sLevelLayout_313528.header, 0x10, 4, 0x61, 3, 0);
}

void sub_08025240(void)
{
    Entity_WalkCompactRecords(0x27, &sLevelLayout_313528.header, 4, &gIwram_6110, 0);
}
