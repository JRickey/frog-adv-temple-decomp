#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312DA8[11];

void sub_080240E0(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_312DA8[i], i + 0x28);
        i++;
    } while (i <= 10);

    sub_08020FE4(0x28, 0x29);
    sub_08005D10(0x28, 0x29);
    sub_08020FE4(0x2a, 0x31);
    sub_08005D10(0x2a, 0x31);
    sub_08020FE4(0x32, 0x32);
    sub_08005D10(0x32, 0x32);
}
