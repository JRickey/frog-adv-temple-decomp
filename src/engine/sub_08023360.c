#include "iwram.h"
#include "types.h"

extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_311CE0[22];

void sub_08023360(void)
{
    sub_08021510(0x43, sLevelLayout_311CE0, 2, &gIwram_6110, 0);
}
