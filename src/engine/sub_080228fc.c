#include "iwram.h"
#include "types.h"

extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_310C44[12];

void sub_080228FC(void)
{
    sub_08021510(0x47, sLevelLayout_310C44, 16, &gIwram_6110, 0);
}
