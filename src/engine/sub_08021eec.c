#include "iwram.h"
#include "types.h"

extern void sub_08020F3C(u8 idx);
extern void sub_080219BC(void *obj, u8 idx);
extern void sub_080059C4(void *p);

void sub_08021EEC(void *obj, u8 idx)
{
    sub_08020F3C(idx);
    sub_080219BC(obj, idx);
    sub_080059C4((u8 *)&gIwram_3720 + idx * 56);
}
