#include "types.h"

extern void sub_0802D558(void *src, void *dst, u32 count);

void sub_0800A05C(void)
{
    u32 scratch[2];
    void *fillSrc;

    scratch[0] = 0;
    sub_0802D558(&scratch[0], (void *)0x06010000, 0x01000008);

    fillSrc = &scratch[1];

    {
        u16 *oamBase;
        u16 *oamFirst;
        u16 *oamRest;
        u32 zero;
        u32 hiddenY;
        u16 *oamEnd;
        u16 **firstRef;
        u16 **restRef;

        oamBase = (u16 *)0x030054a0;
        zero = 0;
        oamFirst = oamBase;
        oamEnd = (u16 *)((u8 *)oamBase + (254 << 2));
        hiddenY = 0xf0;
        oamRest = oamBase;
        do {
            u16 *clear;
            s32 i;

            (*(firstRef = &oamFirst))[0] = hiddenY;
            clear = (*(restRef = &oamRest)) + 1;
            i = 2;
            do {
                clear[0] = zero;
                clear++;
                i--;
            } while (i >= 0);
            oamFirst += 4;
            oamRest += 4;
        } while ((s32)oamFirst <= (s32)oamEnd);

        {
            void *oamDst;
            u32 oamCount;

            oamDst = (void *)0x07000000;
            oamCount = 0x100;
            sub_0802D558(oamBase, oamDst, oamCount);
        }
    }

    {
        u8 *hit;
        register s32 i asm("r5");
        u32 zero;

        i = 0;
        zero = 0;
        hit = (u8 *)0x03006160;
        do {
            *(u16 *)(hit + 2) = zero;
            hit[0] = i;
            hit += 8;
            i++;
        } while (i <= 0x3f);
    }

    scratch[1] = 0;

    {
        u8 *ent;
        register u32 mask asm("r1");
        register s32 j asm("r5");

        ent = (u8 *)0x03003720;
        sub_0802D558(fillSrc, ent, 0x01000700);

        mask = 8;
        ent += 0x34;
        j = 0x7f;
        do {
            *(u16 *)ent |= mask;
            ent += 0x38;
            j--;
        } while (j >= 0);
    }
}
