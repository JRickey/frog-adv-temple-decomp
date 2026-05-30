#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_0800276C(void)
{
    sub_0800658C((void *)0x03006110, 0x78, 8, (const void *)0x082f9a84, 1, 3);
    sub_0800CE98(8, 0);
    sub_08009CBC();
}

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u32 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern void sub_0800C3E4(u8 mode);

void sub_080027A0(void)
{
    u32 mask;
    struct IwramAt35E0 *p;

    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    p = &gIwram_35E0;
    mask = 0x10;
    mask &= p->_field_10;
    if (mask != 0) {
        u8 result = (u8)sub_0800CD88(p->_field_18, p->_field_19, p->_field_8, p->_field_A);
        sub_0800C3E4(result);
    }
    gGameStuff._unk14++;
}

extern u32 sub_08009C14(u8 *state);

void sub_080027F0(u8 *state)
{
    if (sub_08009C14(state) == 0)
        *state = 7;
}

extern void sub_0800DE80(void);

void sub_08002808(void)
{
    sub_0800DE80();
}
