#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_0800696C(void *p, s32 idx);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312D60[8];

void sub_08023FAC(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_312D60[i], i + 2);
        i++;
    } while (i <= 7);

    sub_0800696C(&gIwram_6110, 2);
    sub_0800696C(&gIwram_6110, 3);
    sub_08020FE4(2, 9);
    sub_08005D10(2, 9);
}
