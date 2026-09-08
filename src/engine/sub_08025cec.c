#include "entity.h"
#include "level_layout.h"
#include "level_layout_data.h"
#include "iwram.h"

void sub_08025CEC(void)
{
    LevelLayout_WalkRecords(2, &sLevelLayout_3140B8.header, 0x10, 4, 0x41, 1, 0);
}

void sub_08025D14(void)
{
    Entity_WalkCompactRecords(2, &sLevelLayout_3140B8.header, 4, &gIwram_6110, 0);
}

void sub_08025D38(void)
{
    LevelLayout_WalkRecords(7, &sLevelLayout_3140E8.header, 0x10, 2, 0x51, 2, 0);
}

void sub_08025D60(void)
{
    Entity_WalkCompactRecords(7, &sLevelLayout_3140E8.header, 2, &gIwram_6110, 0);
}

void sub_08025D84(void)
{
    LevelLayout_WalkRecords(0x26, &sLevelLayout_3141E8.header, 0x10, 0xB, 0x61, 3, 0);
}

void sub_08025DAC(void)
{
    Entity_WalkCompactRecords(0x26, &sLevelLayout_3141E8.header, 0xB, &gIwram_6110, 0);
}

void sub_08025DD0(void)
{
    LevelLayout_WalkRecords(0x29, &sLevelLayout_314208.header, 0x10, 0x22, 0x181, 4, 0);
}
