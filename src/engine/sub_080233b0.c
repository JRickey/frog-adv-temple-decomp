#include "iwram.h"
#include "types.h"

extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_311D38[8];

void sub_080233B0(void)
{
    sub_08021510(0x4e, sLevelLayout_311D38, 0xb, &gIwram_6110, 0);
}
