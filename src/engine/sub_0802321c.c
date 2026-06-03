#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayoutData_3114C0[];

void sub_0802321C(void)
{
    sub_08021140(6, sLevelLayoutData_3114C0, 0, 0x12, 0x61, 3, 0);
}
