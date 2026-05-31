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
