#include "types.h"

void sub_08015D54(void)
{
    vu16 *reg = (vu16 *)0x0400000A;
    u16 val = *reg;
    u16 mask = 0xFFFC;

    *reg = val & mask;
    *reg = *reg | 1;
    reg++;
    *reg = *reg & mask;
    *reg = *reg | 2;
}
