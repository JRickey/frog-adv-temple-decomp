#include "game.h"

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u32 sub_08009C14(u8 *state);

void sub_080040C4(void)
{
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    gGameStuff._unk14++;
}

void sub_080040EC(u8 *state)
{
    if (sub_08009C14(state) == 0)
        *state = 8;
}
