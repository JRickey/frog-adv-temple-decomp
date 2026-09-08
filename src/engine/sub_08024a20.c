#include "entity.h"
#include "level_layout.h"
#include "level_layout_data.h"
#include "iwram.h"
#include "types.h"

void sub_08024A20(void)
{
    LevelLayout_WalkRecords(0x4a, &sLevelLayout_31326C.header, 0x10, 0xb, 0xf1, 7, 0);
}

void sub_08024A48(void)
{
    Entity_WalkCompactRecords(0x4a, &sLevelLayout_31326C.header, 0xb, &gIwram_6110, 0);
}

void sub_08024A6C(void)
{
    LevelLayout_WalkRecords(0x4b, &sLevelLayout_31327C.header, 0x10, 0x17, 0x101, 8, 0);
}

void sub_08024A98(void)
{
    LevelLayout_WalkRecords(0x53, &sLevelLayout_312EDC.header, 0, 0x4c, 0x1c1, 10, 0);
}

void sub_08024AC4(void)
{
    Entity_WalkCompactRecords(0x53, &sLevelLayout_312EDC.header, 0x4c, &gIwram_6110, 0);
}
