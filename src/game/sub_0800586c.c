#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800AF50(u32 arg);

void sub_0800586C(u32 arg)
{
    gGameStuff.pendingMode = 16;
    sub_0800AF50(arg);
    gIwram_6110._field_33 = 0;
}
