#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08006BB4(u8 partId, u8 *out);
extern void sub_0800B7B0(u32 a, u32 b, u8 c);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern u32 sub_08009C14(u8 *state);
extern void sub_0800DE80(void);

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

void sub_08004D04(void)
{
    sub_0800DE80();
}

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);
extern void sub_0800BF24(u8 *slots, u32 *out, s8 type);
extern void sub_0800BEBC(u8 *slots, u32 *out, s8 type, u8 tile);
extern void sub_0800CBE8(u8 col, u8 row, u32 a, u32 b, u32 c);
extern u8 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern void sub_08015A50(void);
extern void sub_08015A80(void);
extern void sub_080124D0(void);
extern void sub_08016A40(void);
extern void sub_08020C78(u32 arg);

void sub_08004D10(u8 *arg0, u32 *arg1, u8 *arg2, u32 *arg3)
{
    if ((u8)sub_0800679C((u8 *)&gIwram_6110, 3, 3)) {
        u8 *base3720 = (u8 *)gEntities;
        u32 off = 0xaf2;
        *(u16 *)(base3720 + off) = 0;
        sub_08006600((u8 *)&gIwram_6110, 3, 4);
        sub_080066C4((u8 *)&gIwram_6110, 3, 3);
    }

    if ((u8)sub_0800679C((u8 *)&gIwram_6110, 3, 4)) {
        sub_08006600((u8 *)&gIwram_6110, 3, 5);
        sub_08006600((u8 *)&gIwram_6110, 3, 0);
        sub_080066C4((u8 *)&gIwram_6110, 3, 6);

        if (gIwram_6110.spawnMask == 1) {
            sub_08015A50();
            sub_0800BE18(arg0, arg1, 29);
            sub_0800BE18(arg2, arg3, 30);
        }

        gIwram_6110.byteFlags8 = 0;
        gIwram_6110.gateByte = 0;
        sub_080066C4((u8 *)&gIwram_6110, 3, 4);
    }

    if (gIwram_35E0._data[4] == 5) {
        u32 mask = gIwram_6110.spawnMask + 1;
        gIwram_6110.spawnMask = mask;
        gIwram_6110.flags0 = 0;
        gIwram_35E0._data[4] = 0;
        gIwram_6110.byteFlags8 = 0;
        gIwram_6110.gateByte = 0;

        if ((u8)mask == 4) {
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 7, 4, 15);
            sub_0800CBE8(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 4, 15);
            gIwram_6110.inputFlags |= 8;
            sub_080066C4((u8 *)&gIwram_6110, 3, 7);
            return;
        }

        sub_080066C4((u8 *)&gIwram_6110, 3, 7);

        if (gIwram_6110.spawnMask == 1) {
            sub_0800BE18(arg0, arg1, 29);
            sub_0800BE18(arg2, arg3, 30);
        }

        if (gIwram_6110.spawnMask == 2) {
            sub_0800BE18(arg0, arg1, 29);
            sub_0800BE18(arg2, arg3, 30);
            sub_08015A80();
        }

        sub_080124D0();
        sub_08020C78(28);

        {
            u8 *base3720 = (u8 *)gEntities;
            u32 off = 0xb10;
            /* Pinning the OR mask to r3 makes agbcc materialize `movs r3, #8`
               in the loop preheader before the induction-variable setup,
               matching the baserom's `movs r3,#8; adds r2,#0xdc; movs r1,#15`
               order (a plain literal puts the movs after the IV inits). */
            register u32 bit asm("r3");
            s32 i;
            u16 *p;

            *(u32 *)(base3720 + off) = gGameStuff._unk00;

            bit = 8;
            p = (u16 *)(base3720 + 0xdc);
            for (i = 15; i >= 0; i--) {
                *p |= bit;
                p = (u16 *)((u8 *)p + 0x38);
            }
        }

        sub_08016A40();
        sub_08006600((u8 *)&gIwram_6110, 3, 8);
    }

    if ((u8)sub_0800679C((u8 *)&gIwram_6110, 3, 9)) {
        u32 *g = &gGameStuff._unk00;
        u8 *base3720 = (u8 *)gEntities;
        u32 off = 0xb48;
        if (*g - *(u32 *)(base3720 + off) > 120) {
            sub_08006600((u8 *)&gIwram_6110, 3, 0);
            sub_08006600((u8 *)&gIwram_6110, 3, 5);
            gIwram_6110.gateByte = 0;
            sub_080066C4((u8 *)&gIwram_6110, 3, 9);
        }
    }

    if (gIwram_6110.spawnMask == 1) {
        /* short-circuit || — the baserom skips the second probe when the
           first is set, so the calls must stay inside the condition */
        if ((u8)sub_0800679C((u8 *)&gIwram_6110, 3, 0) || (u8)sub_0800679C((u8 *)&gIwram_6110, 3, 7)) {
            sub_0800BF24(arg0, arg1, 29);
            sub_0800BF24(arg2, arg3, 30);
        }
    }

    if ((gIwram_35E0._field_10 & 0x10) == 0)
        return;
    if (gIwram_6110.spawnMask != 1)
        return;
    if ((u8)sub_0800679C((u8 *)&gIwram_6110, 3, 0) == 0)
        return;

    {
        u8 tile =
            (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
        sub_0800BEBC(arg0, arg1, 29, tile);
        sub_0800BEBC(arg2, arg3, 30, tile);
    }
}
