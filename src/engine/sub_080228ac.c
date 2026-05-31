#include "iwram.h"
#include "types.h"

extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_310B84[42];

void sub_080228AC(void)
{
    sub_08021510(5, sLevelLayout_310B84, 2, &gIwram_6110, 0);
}
