#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_08006B88(struct IwramAt35E0 *p, u32 mask);
extern void sub_08015194(void);
extern void sub_08014EA8(void);
extern u8 sub_0801436C(void);

void sub_0802BDBC(void)
{
    u16 *new_var;
    int scratch;

    if (gIwram_6110.gateByte > 5)
        return;

    if ((u8)sub_0800679C((u8 *)&gIwram_6110, 3, 5)) {
        u8 *p1;

        sub_08015194();
        p1 = (u8 *)gEntities;
        new_var = (u16 *)(p1 + 0xaf2);
        scratch = 0;
        *new_var = 1;
        *(u8 *)((u8 *)gEntities + 0x4ea) = scratch;
        *(u16 *)((u8 *)gEntities + 0x504) |= 2;
        *(u32 *)((u8 *)gEntities + 0xb1c) = gGameStuff._unk00;
        sub_080066C4((u8 *)&gIwram_6110, 3, 5);
        sub_080066C4((u8 *)&gIwram_6110, 3, 6);
    }

    {
        u8 *p2 = (u8 *)gEntities;
        if (*(u16 *)(p2 + 0xaf2) == 2 && gGameStuff._unk00 - *(u32 *)(p2 + 0xb1c) > 180) {
            sub_08014EA8();
            *(u16 *)(p2 + 0xaf2) += 1;
            sub_08006600((u8 *)&gIwram_6110, 3, 6);
        }
    }

    scratch = 0xaf2;
    if (sub_0801436C()) {
        u8 *base;
        u8 *p3;
        s32 st;

        base = (u8 *)gEntities;
        st = *(s16 *)(base + scratch);
        p3 = base;
        switch (st) {
        case 3:
            base = p3 + 0xb1c;
            *(u32 *)base = gGameStuff._unk00;
            /* Keeps agbcc's reload cursor aligned for the fallthrough state increment. */
            gEntities[0].status++;
            gEntities[0].status--;
        case 1:
            *(u16 *)(p3 + 0xaf2) += 1;
            break;
        case 4:
            if (++gIwram_6110.gateByte == 6)
                sub_08006600((u8 *)&gIwram_6110, 3, 6);
            else
                sub_08006600((u8 *)&gIwram_6110, 3, 5);
            break;
        case 0:
        case 2:
        default:
            break;
        }
    }

    if (gGameStuff._unk10 & 1)
        return;
    if (gEntities[0].status & 4)
        return;
    if ((u16)(*(u16 *)((u8 *)gEntities + 0xaf2) - 2) > 1)
        return;

    {
        struct IwramAt35E0 *e = &gIwram_35E0;

        if (e->_field_8 == 1 || e->_field_8 == 12 || e->_field_A == 4 || e->_field_A == 11)
            sub_08006B88(e, 0x400);
    }
}
