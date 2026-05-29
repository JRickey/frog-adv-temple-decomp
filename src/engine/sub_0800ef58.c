#include "types.h"

extern void sub_0800E85C(u8 arg);
extern void sub_08016360(const void *src, u8 arg);
extern void sub_0800EB1C(void);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

void sub_0800EF58(void)
{
    sub_0800E85C(2);
    sub_08016360((const void *)0x08306944, 5);
    sub_0800EB1C();
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
    *(vu32 *)0x03006420 = 0;
}
