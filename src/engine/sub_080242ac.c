#include "iwram.h"
#include "types.h"

extern void sub_08021140(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

extern const u32 sLevelLayout_312248[];

void sub_080242AC(void)
{
    sub_08021140(0x61, sLevelLayout_312248, 0x10, 0x11, 0x1c1, 8, 0);
}
