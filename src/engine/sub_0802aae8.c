#include "iwram.h"
#include "types.h"

extern void sub_08021140(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);
extern const u32 sLevelLayout_317DC4[6];

void sub_0802AAE8(void)
{}

void sub_0802AAEC(void)
{
    sub_08021140(10, sLevelLayout_317DC4, 16, 90, 0xc1, 2, 0);
}
