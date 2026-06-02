#include "types.h"

extern u8 sub_0801B154(void);
extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const void *sLevelLayoutPtrs_308698[];

void sub_0801BADC(void)
{
    u8 idx = sub_0801B154();
    const void *layout;

    if (idx == 16)
        idx = 15;

    layout = sLevelLayoutPtrs_308698[idx];
    sub_08021140(4, layout, 0, 0x33, 100, 3, 0);
}

void sub_0801BB18(void)
{}
