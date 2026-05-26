#include "game.h"
#include "types.h"

/* Mode-init dispatcher: sequences a fixed set of subsystem resets, hands
 * off to sub_08000B6C with the caller's two args, then bumps a frame/tick
 * counter at gGameStuff offset 0x14. The first three callees take no args
 * (subsystem teardown), the fourth is a config loader (ROM table
 * 0x08306944, count 5), the last two are continued teardown. */

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_08016404(u32 src, u32 count);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08000B6C(u32 a, u32 b);

void sub_08000CEC(u32 a, u32 b)
{
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_08016404(0x08306944, 5);
    sub_080094F8();
    sub_08009984();
    sub_08000B6C(a, b);
    gGameStuff._unk14++;
}
