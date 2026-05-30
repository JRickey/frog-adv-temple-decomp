#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u32 sub_08009C14(u8 *state);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);

void sub_08003BFC(u8 *state, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u8 *arg5, u32 *arg6)
{
    if (sub_08009C14(state) == 0)
        *state = 7;

    sub_0800B7B0(arg1, arg2, 6);
    sub_0800B7B0(arg3, arg4, 7);
    sub_0800BE18(arg5, arg6, 22);
}
