#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

extern void sub_0800AF50(u32 arg);

void sub_0800586C(u32 arg)
{
    gGameStuff.pendingMode = 16;
    sub_0800AF50(arg);
    gIwram_6110._field_33 = 0;
}

void sub_08005890(void)
{
    struct IwramAt6110 *p = &gIwram_6110;
    sub_0800658C(p, 0x50, 17, (const void *)0x082f9cf0, 1, 0);
    sub_0800CE98(17, 0);
    sub_08009CBC();
    p->_field_10 = 4;
}

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_08005404(u32 arg);

void sub_080058CC(u32 arg)
{
    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();
    sub_08005404(arg);
    gGameStuff._unk14++;
}

extern u32 sub_08009C14(u8 *state);
extern void sub_080066C4(u32 base, u32 idx, u32 val);

void sub_080058FC(u8 *state, u32 arg)
{
    u8 *base;
    u8 *p;
    s8 i;

    if (sub_08009C14(state) == 0) {
        *state = 9;
    }
    sub_0800AF50(arg);
    base = (u8 *)0x03006110;
    base[0x2a] = 0;
    sub_080066C4((u32)base, 5, 4);
    i = 0;
    p = base;
    for (; i <= 3; i++) {
        if (!((p[0x33] >> i) & 1)) {
            sub_080066C4((u32)p, 5, (u8)i);
        }
    }
}

extern void sub_0800C4A0(void);
extern void sub_0800A520(void);

void sub_08005960(void)
{
    sub_0800C4A0();
    while ((u8)sub_0800679C((u8 *)0x03006110, 8, 2) == 0) {
        sub_0800A520();
        sub_0800A2D8();
        sub_080008DC();
        sub_0800A328();
    }
    {
        u8 *base = (u8 *)0x03006110;
        sub_080066C4((u32)base, 8, 2);
        base[0x2a] = 0;
        sub_080066C4((u32)base, 5, 4);
    }
}
