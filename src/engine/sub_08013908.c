#include "macros.h"
#include "types.h"

extern void sub_0800EE34(u8 layer);

/* Clears the byte at IWRAM 0x03003610, then turns off BG2 via sub_0800EE34. */

void sub_08013908(void)
{
    *(u8 *)0x03003610 = 0;
    sub_0800EE34(2);
}
