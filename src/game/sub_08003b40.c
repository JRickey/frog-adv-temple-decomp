#include "game.h"
#include "types.h"

extern void sub_08006BB4(u32 arg, void *buf);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);

void sub_08003B40(u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u8 *arg5, u32 *arg6)
{
    gGameStuff.pendingMode = 11;
    sub_08006BB4(1, (void *)arg0);
    sub_0800B7B0(arg1, arg2, 6);
    sub_0800B7B0(arg3, arg4, 7);
    sub_0800BE18(arg5, arg6, 22);
}
