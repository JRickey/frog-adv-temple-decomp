#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern void sub_0802B3B0(void);
extern void sub_0802B4B8(void);
extern void sub_0800DA10(void);
extern void sub_0800D1F8(void);
extern u8 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_080066C4(void *base, u32 selector, u32 bit);
extern void sub_08006600(void *base, u32 selector, u32 bit);
extern void sub_08015D30(void);
extern void sub_08020DC4(u32 arg0);
extern void sub_08020E7C(u32 arg0);
extern void sub_08020C78(u32 arg0);
extern u8 sub_080142D4(void);
extern void sub_08006B88(void *p, u16 mask);

extern const u32 sLevelLayout_317FD0[];

void sub_0802BC24(void)
{
    sub_08021140(0x17, sLevelLayout_317FD0, 0x10, 0x57, 0x89, 3, 0);
}

void sub_0802BC4C(void)
{
    u8 i;

    for (i = 0; i <= 3; i++) {
        u32 off;
        u32 *dst;
        const u32 *src;
        u32 hi;
        u32 lo;

        off = i << 3;
        dst = (u32 *)(0x03003570 + off);
        src = (const u32 *)(0x08317ffc + off);
        hi = src[1];
        lo = src[0];
        dst[1] = lo;
        dst[2] = hi;
    }

    sub_0802B3B0();
    sub_0800DA10();
}

void sub_0802BC84(void)
{
    sub_0802B4B8();
    sub_0800D1F8();
}

void sub_0802BC94(void)
{
    struct IwramAt6110 *ctrl = &gIwram_6110;
    u8 gate;
    s32 delta;
    s32 y;

    gate = ctrl->gateByte;
    if (gate != 0)
        return;

    if (sub_0800679C(ctrl, 3, 5)) {
        sub_08015D30();
        gEntities[22].field_1A = gate;
        gEntities[22].status |= 2;
        sub_080066C4(ctrl, 3, 5);
        return;
    }

    {
        u32 p6540;
        u32 pent;

        p6540 = 0x03006540;
        pent = (u32)gEntities;
        asm("ldrh\t%1, [%1, #0x36]\n\tldrh\t%0, [%0, #0x4]\n\tsub\t%0, %1, %0" : "+r"(pent), "+r"(p6540));
        delta = (s16)pent;
    }
    if (delta < 0)
        delta = -delta;
    if ((s16)delta <= 71)
        sub_08020DC4(2);
    else
        sub_08020E7C(2);

    if (sub_080142D4()) {
        sub_08020E7C(2);
        if (++gIwram_6110.gateByte == 1)
            sub_08006600(&gIwram_6110, 3, 6);
        else
            sub_08006600(&gIwram_6110, 3, 5);
    }

    if (gGameStuff._unk10 & 1)
        return;
    if (gEntities[0].status & 4)
        return;

    y = gEntities[0].y;
    {
        struct {
            u8 _pad[0x36];
            s16 _field_36;
        } *p6540 = (void *)0x03006540;
        if (y <= p6540->_field_36 - 22)
            return;
        if (y >= p6540->_field_36 - 10)
            return;
    }

    if ((u8)(gEntities[0].field_1A - 8) <= 3)
        return;

    sub_08020C78(0x5b);
    sub_08006B88(&gIwram_35E0, 0x4000);
}
