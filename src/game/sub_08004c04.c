#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08006BB4(u8 partId, u8 *out);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern u32 sub_08009C14(u8 *state);

void sub_08004C04(u8 *buf, u32 arg1, u32 arg2)
{
    gGameStuff.pendingMode = 14;
    sub_08006BB4(5, buf);
    sub_0800B7B0(arg1, arg2, 17);
}

extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08004C30(void)
{
    ModeControl_Init(&gIwram_6110, 0x80, 0xf, (const void *)0x082f9bd0, 1, 5);
    sub_0800CE98(0xf, 0);
    sub_08009CBC();
}

extern void sub_08007660(u32 a, u32 b);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_080045EC(u32 a, u32 b);

void sub_08004C64(u32 a, u32 b, u32 c)
{
    sub_08007660(5, a);
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_080045EC(b, c);
    gGameStuff._unk14++;
}

void sub_08004CA4(u8 *state, u32 arg1, u32 arg2)
{
    u8 *base;

    if (gIwram_35E0._field_5 <= 2) {
        base = (u8 *)&gIwram_6110;
        sub_080066C4(base, 3, 0);
        sub_080066C4(base, 3, 1);
    } else {
        sub_08006600((u8 *)&gIwram_6110, 3, 1);
    }

    if (sub_08009C14(state) == 0)
        state[0] = 7;

    sub_0800B7B0(arg1, arg2, 17);
}
