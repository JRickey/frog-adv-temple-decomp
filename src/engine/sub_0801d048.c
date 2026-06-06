#include "types.h"

extern const u8 sLevelClearedLabels[124];

extern void DrawTextGlyphs(const u8 *str, int x, int y, int a, int b, int c, int d);
extern void DrawByteDecimal(u8 value, int x, int y, int a, int b, int c);

void LevelCleared_ShowKindLabel(u8 value)
{
    DrawTextGlyphs(&sLevelClearedLabels[0], 5, 11, 10, 278, 14, 3);
    DrawByteDecimal(value, 17, 10, 278, 14, 3);
}
