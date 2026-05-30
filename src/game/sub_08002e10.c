#include "iwram.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08002E10(void)
{
    sub_0800658C(&gIwram_6110, 0x50, 10, (const void *)0x082f9cc0, 1, 0);
    sub_0800CE98(10, 0);
    sub_08009CBC();
}
