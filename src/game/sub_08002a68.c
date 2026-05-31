#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08002A68(void)
{
    sub_0800658C((void *)0x03006110, 0x64, 9, (const void *)0x082f9ab8, 1, 5);
    sub_0800CE98(9, 0);
    sub_08009CBC();
}

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);

void sub_08002A9C(void)
{
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    gGameStuff._unk14++;
}

extern u32 sub_08009C14(u8 *state);

void sub_08002AC4(u8 *state)
{
    if (sub_08009C14(state) == 0)
        *state = 7;
}
