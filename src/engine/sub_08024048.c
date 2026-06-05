#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);

extern const u32 sLevelLayout_312148[];

void sub_08024048(void)
{
    sub_08021140(20, sLevelLayout_312148, 0x410, 2, 0xa1, 3, 0);
}
