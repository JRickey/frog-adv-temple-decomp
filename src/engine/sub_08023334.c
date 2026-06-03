#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_311CE0[22];

void sub_08023334(void)
{
    sub_08021140(0x43, sLevelLayout_311CE0, 0, 2, 0x151, 9, 0);
}
