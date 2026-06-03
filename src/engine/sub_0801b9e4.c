#include "types.h"

extern u8 sub_0801B71C(u8 arg);
extern u16 gIwram_5398;

u32 sub_0801B9E4(u8 arg)
{
    register u8 argReg asm("r3") = arg;
    register u32 ret asm("r2") = 1;
    register u8 *state asm("r4") = (u8 *)0x03006440;
    register u32 *frameCounter asm("r5");

    if (*(u16 *)(state + 0x30) == 0)
        state[0x0B] = 8;

    frameCounter = (u32 *)0x03005330;
    if (*frameCounter - *(u32 *)(state + 4) >= state[0x0B]) {
        ret = (u8)sub_0801B71C(argReg);
        *(u32 *)(state + 4) = *frameCounter;
    }

    if (gIwram_5398 == 0x20)
        ret = 0xFE;

    return ret;
}

extern void sub_0802D558(void *src, void *dst, u32 mode);
extern void sub_0801BAD8(void);
extern void sub_0801BADC(void);

void sub_0801BA34(void)
{
    s32 zero2;
    u32 zero;
    u8 *ent;
    s32 j;

    zero2 = 0;
    {
        register u16 *vram asm("r0");
        register s32 i asm("r1");

        vram = (u16 *)0x06010000;
        i = 0xF;
        do {
            *vram = zero2;
            vram++;
            i--;
        } while (i >= 0);
    }

    {
        register s32 zero_h asm("r4") = 0;
        register s32 sentinel asm("r5");
        register s32 oam_end asm("r6");
        register u16 *oam asm("r2");
        register u16 *cur asm("r3");

        oam = (u16 *)0x030054a0;
        oam_end = (s32)((u32)oam + (0xFE << 2));
        sentinel = 0xF0;
        cur = oam;
        do {
            register u16 *inner asm("r0");
            s32 n;

            *oam = sentinel;
            inner = cur + 1;
            n = 2;
            do {
                *inner = zero_h;
                inner++;
                n--;
            } while (n >= 0);
            oam += 4;
            cur += 4;
        } while ((s32)oam <= oam_end);
    }

    {
        s32 i = 0;
        s32 zero_h = 0;
        u16 *hit = (u16 *)0x03006160;
        do {
            *(hit + 1) = zero_h;
            *(u8 *)hit = i;
            hit += 4;
            i++;
        } while (i <= 0x3F);
    }

    zero = 0;
    ent = (u8 *)0x03003720;
    {
        /* Load fill mode into r2 before sp → r0 to match baserom instruction ordering. */
        register u32 fill_mode asm("r2") = 0x01000700;
        sub_0802D558(&zero, ent, fill_mode);
    }
    {
        register s32 mask asm("r2") = 8;

        ent += 0x34;
        for (j = 0x7F; j >= 0; j--) {
            *(u16 *)ent |= mask;
            ent += 0x38;
        }
    }

    sub_0801BAD8();
    sub_0801BADC();
}
