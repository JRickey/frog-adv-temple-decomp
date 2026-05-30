#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_310DD4[8];

void sub_0802277C(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_310DD4[i], i + 0x36);
        i++;
    } while (i <= 7);

    sub_08020FE4(0x36, 0x3d);
    sub_08005D10(0x36, 0x3d);
}
