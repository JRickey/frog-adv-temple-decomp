#include "gba/syscall.h"
#include "types.h"

extern u8 sub_0801B71C(u8 arg);
extern u16 gIwram_5398;

u32 Credits_StepThrottled(u8 arg)
{
    u8 argReg = arg;
    u32 ret = 1;
    u8 *state = (u8 *)0x03006440;
    u32 *frameCounter;

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

extern void sub_0801BAD8(void);
extern void LoadWorldLevelLayoutAlt(void);

void Credits_InitScene(void)
{
    s32 zero2;
    u32 zero;
    u8 *ent;
    s32 j;

    zero2 = 0;
    {
        u16 *vram;
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
        s32 sentinel;
        s32 oam_end;
        u16 *oam;
        u16 *cur;

        oam = (u16 *)0x030054a0;
        oam_end = (s32)((u32)oam + (0xFE << 2));
        sentinel = 0xF0;
        cur = oam;
        do {
            u16 *inner;
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
        u32 fill_mode = 0x01000700;
        CpuFastSet(&zero, ent, fill_mode);
    }
    {
        s32 mask = 8;

        ent += 0x34;
        for (j = 0x7F; j >= 0; j--) {
            *(u16 *)ent |= mask;
            ent += 0x38;
        }
    }

    sub_0801BAD8();
    LoadWorldLevelLayoutAlt();
}
