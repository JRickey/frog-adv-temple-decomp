#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

void sub_08002E10(void)
{
    sub_0800658C(&gIwram_6110, 0x50, 10, (const void *)0x082f9cc0, 1, 0);
    sub_0800CE98(10, 0);
    sub_08009CBC();
}

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u32 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern void sub_0800ACE8(u8 arg);

void sub_08002E44(void)
{
    struct IwramAt35E0 *p;
    register u32 mask asm("r0");

    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();

    p = &gIwram_35E0;
    mask = 0x10;
    mask &= p->_field_10;
    if (mask != 0) {
        sub_0800ACE8((u8)sub_0800CD88(p->_field_18, p->_field_19, p->_field_8, p->_field_A));
    }

    gGameStuff._unk14++;
}
