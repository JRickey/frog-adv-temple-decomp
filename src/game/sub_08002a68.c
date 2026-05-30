#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08002A68(void)
{
    sub_0800658C((void *)0x03006110, 0x64, 9, (const void *)0x082f9ab8, 1, 5);
    sub_0800CE98(9, 0);
    sub_08009CBC();
}
