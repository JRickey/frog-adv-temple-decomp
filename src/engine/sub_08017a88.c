#include "iwram.h"
#include "macros.h"
#include "types.h"

void sub_08017AA8(void);

void sub_08017A88(void)
{
    sub_08017AA8();
    gIwram_35E0._data[0] = gIwram_34B4._data[2];
    *(u16 *)&gIwram_35E0._data[2] = 0;
}
