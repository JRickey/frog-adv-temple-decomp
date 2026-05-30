#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08007660(u32 id, void *obj);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08003668(u32 arg0, u32 arg1, u32 arg2, u32 arg3, void *arg4, void *arg5);

void sub_08003C38(void *arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, void *arg5, void *arg6)
{
    sub_08007660(1, arg0);
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_08003668(arg1, arg2, arg3, arg4, arg5, arg6);
    gGameStuff._unk14++;
}
