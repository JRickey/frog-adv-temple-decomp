#include "game.h"

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08004D10(u32 a0, u32 a1, u32 a2, u32 a3);

void sub_08005308(u32 a0, u32 a1, u32 a2, u32 a3)
{
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_08004D10(a0, a1, a2, a3);
    gGameStuff._unk14++;
}
