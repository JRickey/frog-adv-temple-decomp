#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "game.h"

extern s8 sub_0800A7A8(s8 a, s16 x, s16 y);
extern u8 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern u32 sub_08020C78(u32 sound);
extern u8 sub_08000764(u8 range);

void sub_0800AB84(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    s8 result;
    register u8 *base asm("r0");
    register u8 *base5 asm("r5");
    register u32 bit asm("r2");
    register u8 *checkBase asm("r4");

    if (tile != 20)
        return;

    p35E0 = &gIwram_35E0;
    result = sub_0800A7A8(19, p35E0->_field_8, p35E0->_field_A);

    if (result != 0)
        goto nonzero;

    base = (u8 *)0x03006110;
    bit = (u8)result;
    goto set5;

nonzero:
    base5 = (u8 *)0x03006110;
    bit = (u8)(result - 1);
    if (sub_0800679C(base5, 5, bit) == 0)
        goto play;

    bit = (u8)result;
    base = base5;

set5:
    sub_08006600(base, 5, bit);
    goto check;

play:
    sub_08020C78(114);

check:
    checkBase = (u8 *)0x03006110;
    if (sub_0800679C(checkBase, 5, 0) == 0)
        return;
    if (sub_0800679C(checkBase, 5, 1) == 0)
        return;
    if (sub_0800679C(checkBase, 5, 2) == 0)
        return;
    if (sub_0800679C(checkBase, 5, 3) == 0)
        return;

    sub_08006600(checkBase, 5, 15);
    sub_080066C4(checkBase, 8, 1);
}

void sub_0800AC44(u8 tile)
{
    u8 *base6110;
    struct IwramAt6110 *p6110;

    if (tile != 20)
        return;

    base6110 = (u8 *)0x03006110;

    if (sub_0800679C(base6110, 5, 0) == 0) {
        sub_08006600(base6110, 5, 0);
        sub_08020C78(25);
        sub_08006600(base6110, 8, 4);
    } else if (sub_0800679C(base6110, 5, 1) == 0) {
        sub_08006600(base6110, 5, 1);
        sub_08020C78(25);
        sub_08006600(base6110, 8, 4);
    } else if (sub_0800679C(base6110, 5, 2) == 0) {
        sub_08006600(base6110, 5, 2);
        sub_08020C78(25);
        sub_08006600(base6110, 8, 4);
    }

    p6110 = &gIwram_6110;
    if (p6110->selector5Flags == 7)
        sub_08006600((u8 *)p6110, 8, 5);

    sub_08006600((u8 *)p6110, 8, 2);
}

extern s8 sub_0800D9FC(s8 idx);

void sub_0800ACE8(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    register struct IwramAt6110 *base5 asm("r5");
    register struct IwramAt6110 *base4 asm("r4");
    register struct IwramAt6110 *base2 asm("r2");
    register u16 flags asm("r1");
    s8 result;

    if (tile == 20) {
        p35E0 = &gIwram_35E0;
        result = (u8)sub_0800A7A8(20, p35E0->_field_8, p35E0->_field_A);

        base5 = &gIwram_6110;
        if (sub_0800679C((u8 *)base5, 5, (u8)result) == 0) {
            sub_08006600((u8 *)base5, 5, (u8)result);
            sub_08020C78(25);
        }

        flags = base5->selector5Flags;
        if ((flags & 1) && (flags & 0x20)) {
            if (sub_0800679C((u8 *)base5, 8, 4) == 0) {
                sub_08006600((u8 *)base5, 8, 4);
                sub_08020C78(52);
            }
        }

        base4 = &gIwram_6110;
        if ((base4->selector5Flags & 0x12) == 0x12) {
            if (sub_0800679C((u8 *)base4, 8, 5) == 0) {
                sub_08006600((u8 *)base4, 8, 5);
                sub_08020C78(52);
            }
        }

        base4 = &gIwram_6110;
        if ((base4->selector5Flags & 0x84) == 0x84) {
            if (sub_0800679C((u8 *)base4, 8, 6) == 0) {
                sub_08006600((u8 *)base4, 8, 6);
                sub_08020C78(52);
            }
        }

        base4 = &gIwram_6110;
        if ((base4->selector5Flags & 0x48) == 0x48) {
            if (sub_0800679C((u8 *)base4, 8, 7) == 0) {
                sub_08006600((u8 *)base4, 8, 7);
                sub_08020C78(52);
            }
        }

        base2 = &gIwram_6110;
        if ((base2->byteFlags8 & 0xf0) == 0xf0)
            sub_08006600((u8 *)base2, 8, 0);
    }

    if (tile == 22) {
        p35E0 = &gIwram_35E0;
        result = sub_0800A7A8(21, p35E0->_field_8, p35E0->_field_A);
        result = sub_0800D9FC((s8)result);
        gIwram_6110.spawnMask = (u8)result;
        sub_08020C78(70);
        sub_08006600((u8 *)&gIwram_6110, 8, 1);
    }
}

void sub_0800AE3C(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    register u8 *spawn asm("r4");
    register u8 *spawn5 asm("r5");
    register struct IwramAt6110 *base6110 asm("r5");
    u8 *base3720;
    s8 result;
    u8 rand;

    if (tile != 20)
        return;

    p35E0 = &gIwram_35E0;
    result = sub_0800A7A8(23, p35E0->_field_8, p35E0->_field_A);

    if (result == -1)
        return;

    if (result == 4) {
        spawn = (u8 *)0x03006110;
        if (sub_0800679C(spawn, 5, 4) != 0)
            return;
        sub_08006600(spawn, 5, 4);

        spawn += 0x33;
        if (*spawn == 15) {
            rand = 0;
            goto write;
        }

        rand = (u8)sub_08000764(4);
        if (((*spawn >> (s8)rand) & 1) == 0)
            goto write;

        spawn5 = spawn;
        do {
            rand = (u8)sub_08000764(4);
        } while (((*spawn5 >> (s8)rand) & 1) != 0);

    write:
        gIwram_6110.gateByte = rand;

        base3720 = (u8 *)&gIwram_3720;
        *(u32 *)(base3720 + 0xb8c) = gGameStuff._unk00;
        *(u16 *)(base3720 + 0xb70) = 1;
        return;
    }

    /* Struct-pointer read (not a folded 0x0300613b literal) keeps the
       0x03006110 base live in r5 across the call cluster. */
    base6110 = (struct IwramAt6110 *)0x03006110;
    if (sub_0800679C((u8 *)base6110, 5, 4) == 0)
        return;
    if (result != base6110->gateByte)
        return;

    sub_08006600((u8 *)base6110, 5, (u8)result);
    result = (s8)(result + 8);
    if (sub_0800679C((u8 *)base6110, 5, (u8)result) != 0)
        return;
    sub_08006600((u8 *)base6110, 5, (u8)result);
}
