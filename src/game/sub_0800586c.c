#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

extern void sub_0800AF50(u32 arg);

void sub_0800586C(u32 arg)
{
    gGameStuff.pendingMode = 16;
    sub_0800AF50(arg);
    gIwram_6110._field_33 = 0;
}

void sub_08005890(void)
{
    struct IwramAt6110 *p = &gIwram_6110;
    sub_0800658C(p, 0x50, 17, (const void *)0x082f9cf0, 1, 0);
    sub_0800CE98(17, 0);
    sub_08009CBC();
    p->_field_10 = 4;
}
