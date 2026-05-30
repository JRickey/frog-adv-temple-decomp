#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_310B64[];

void sub_08022730(void)
{
    sub_08021140(2, sLevelLayout_310B64, 0, 4, 0x41, 1, 0);
}
