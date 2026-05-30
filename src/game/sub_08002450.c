#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08002450(void)
{
    sub_0800658C((void *)0x03006110, 0x19, 7, (const void *)0x082f9bf0, 1, 0);
    sub_0800CE98(7, 0);
    sub_08009CBC();
}
