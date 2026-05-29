#include "macros.h"
#include "types.h"

extern void sub_0801BE7C(const u8 *str, int len, int x, int y, int a, int b, int c);

void sub_0801CF18(u8 value, u8 x, u8 y, u16 a, u16 b, u8 c)
{
    u8 buf[4];
    u8 tens;
    u8 units;

    tens = (u8)(value / 10u);
    units = (u8)(value % 10u);
    buf[0] = tens + 0x30;
    buf[1] = units + 0x30;

    sub_0801BE7C(buf, 2, x, y, a, b, c);
}
