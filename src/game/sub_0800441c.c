#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08006BB4(u32 partId, u8 *out);
extern void sub_08007228(u8 partId, u8 *out, u8 tag);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);

void sub_0800441C(u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 arg5, u32 arg6)
{
    gGameStuff.pendingMode = 13;
    sub_08006BB4(2, (u8 *)arg0);
    sub_08007228(3, (u8 *)arg1, 2);
    sub_08007228(4, (u8 *)arg2, 2);
    sub_0800B7B0(arg3, arg4, 11);
    sub_0800B7B0(arg5, arg6, 16);
}
