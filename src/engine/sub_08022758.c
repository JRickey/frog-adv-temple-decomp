#include "iwram.h"
#include "types.h"

extern const u32 sLevelLayout_310B64[8];
extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);

void sub_08022758(void)
{
    sub_08021510(2, sLevelLayout_310B64, 4, &gIwram_6110, 0);
}
