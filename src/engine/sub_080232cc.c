#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_311C80[12];

void sub_080232CC(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_311C80[i], i + 0x32);
        i++;
    } while (i <= 11);

    sub_08020FE4(0x32, 0x34);
    sub_08005D10(0x32, 0x34);
    sub_08020FE4(0x35, 0x36);
    sub_08005D10(0x35, 0x36);
    sub_08020FE4(0x37, 0x3b);
    sub_08005D10(0x37, 0x3b);
    sub_08020FE4(0x3c, 0x3d);
    sub_08005D10(0x3c, 0x3d);
}
