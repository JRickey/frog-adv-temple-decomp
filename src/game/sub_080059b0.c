#include "game.h"
#include "types.h"

extern void sub_0800DE80(void);
extern u8 sub_0801E118(u8 arg);
extern void sub_0801DA1C(void);

void sub_080059B0(void)
{
    sub_0800DE80();
    sub_0801E118(0);
    sub_0801DA1C();
}
