#include "types.h"

extern u8 sub_0801B154(void);
extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const void *sLevelLayoutPtrs_308698[];

void sub_0801BB1C(void)
{
    u8 idx = sub_0801B154();
    const void *layout;

    if (idx == 16)
        idx = 15;

    layout = sLevelLayoutPtrs_308698[idx];
    sub_08021510(4, layout, 0x33, (void *)0x03006110, 0);
}
