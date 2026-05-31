#include "iwram.h"
#include "types.h"

extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_310C44[12];

void sub_080228FC(void)
{
    sub_08021510(0x47, sLevelLayout_310C44, 16, &gIwram_6110, 0);
}

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_3113C8[8];

void sub_08022920(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_3113C8[i], i + 0x4c);
        i++;
    } while (i <= 7);

    sub_08020FE4(0x4c, 0x53);
    sub_08005D10(0x4c, 0x53);
}
