#include "types.h"

extern const u8 sLevelClearedLabels[124];

extern void sub_0801BE7C(const u8 *str, int x, int y, int a, int b, int c, int d);
extern void sub_0801CF18(u8 value, int x, int y, int a, int b, int c);

void sub_0801D048(u8 value)
{
    sub_0801BE7C(&sLevelClearedLabels[0], 5, 11, 10, 278, 14, 3);
    sub_0801CF18(value, 17, 10, 278, 14, 3);
}
