#include "types.h"

struct Sub0801B154Bits {
    u8 pad00[0x0C];
    u32 bits;
};

u8 sub_0801B154(void)
{
    s8 i = 15;
    u32 bits = ((struct Sub0801B154Bits *)0x03005330)->bits;

    while (i >= 0) {
        if (((bits >> i) & 1) != 0) {
            return (u8)(i + 1);
        }
        i--;
    }

    return 0;
}

u8 sub_0801B188(u32 bits)
{
    s8 i = 15;

    while (i >= 0) {
        if (((bits >> i) & 1) != 0) {
            return (u8)(i + 1);
        }
        i--;
    }

    return 0;
}
