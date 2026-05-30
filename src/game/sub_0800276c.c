#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_0800276C(void)
{
    sub_0800658C((void *)0x03006110, 0x78, 8, (const void *)0x082f9a84, 1, 3);
    sub_0800CE98(8, 0);
    sub_08009CBC();
}
