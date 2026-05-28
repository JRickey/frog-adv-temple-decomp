#include "types.h"

extern const u8 sLevelClearedLabels[124];

extern void sub_0801BE7C(const u8 *str, int x, int y, int a, int b, int c, int d);

void sub_0801D094(void)
{
    sub_0801BE7C(&sLevelClearedLabels[8], 8, 11, 10, 278, 14, 3);
}
