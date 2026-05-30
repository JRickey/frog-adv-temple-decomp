#include "macros.h"
#include "types.h"

extern void sub_0800E85C(u8 arg);
extern void sub_0800EB1C(void);
extern void sub_08010958(u8 arg0, u8 arg1);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

void sub_08014078(void)
{
    sub_0800E85C(2);
    sub_0800EB1C();
    sub_08010958(5, 3);
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}
