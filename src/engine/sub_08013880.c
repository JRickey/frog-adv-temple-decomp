#include "macros.h"
#include "types.h"

extern void sub_0801377C(void);
extern void sub_0800EBDC(u8 arg);
extern void sub_0800EE34(u8 layer);

void sub_08013880(void)
{
    sub_0801377C();
    sub_0800EBDC(2);
    sub_0800EE34(2);
}
