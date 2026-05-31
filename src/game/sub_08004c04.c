#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08006BB4(u8 partId, u8 *out);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);

void sub_08004C04(u8 *buf, u32 arg1, u32 arg2)
{
    gGameStuff.pendingMode = 14;
    sub_08006BB4(5, buf);
    sub_0800B7B0(arg1, arg2, 17);
}

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08004C30(void)
{
    sub_0800658C((void *)0x03006110, 0x80, 0xf, (const void *)0x082f9bd0, 1, 5);
    sub_0800CE98(0xf, 0);
    sub_08009CBC();
}
