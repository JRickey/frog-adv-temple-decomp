#include "macros.h"
#include "iwram.h"
#include "types.h"

extern void sub_080100E4(u32, void *, void *);

struct TileBlit_1288C {
    u8 _pad00[28];
    u8 width;
    u8 _pad1D;
    u8 height;
    u8 _pad1F;
    u8 flags;
    u8 _pad21[7];
    const u16 *const *src;
};

#define sTileBlit_1288C (*(const struct TileBlit_1288C *)0x08306e64)

struct BlitState_1288C {
    u8 _pad00[26];
    u16 stride;
};

void sub_0801288C(void)
{
    const struct TileBlit_1288C *desc;
    const u8 *flagPtr;
    register u32 entityBase;
    u32 xOffset;
    register u32 yOffset asm("r0");
    register u32 hold5 asm("r5");
    register u32 hold6 asm("r6");
    s32 xCoord;
    s32 yCoord;
    register u32 xWork asm("r2");
    u32 yWork;
    register u32 x asm("r8");
    register u32 ipWork asm("ip");
    u32 flags;
    u32 width;
    register u32 height asm("r9");
    const u16 *const *srcBase;
    register u16 *dst asm("r2");
    register const u16 *src asm("r1");
    u32 bank;
    void *flushSrc;
    void *flushDst;
    u32 row;
    u32 nextRow;
    u8 col;
    register u16 *state asm("r4");
    register u16 stride asm("r1");

    desc = &sTileBlit_1288C;
    flagPtr = (const u8 *)desc + 0x20;
    entityBase = 0x03003720;
    xOffset = 0x692;
    xCoord = *(s16 *)(entityBase + xOffset);
    xWork = xCoord * 3 + xOffset - xOffset + hold5 - hold5 + hold6 - hold6;
    xWork <<= 16;
    yOffset = 0x694;
    entityBase -= -yOffset;
    /* Keep yOffset live through the signed load for matching. */
    if (yOffset)
        yCoord = *(s16 *)entityBase;
    else
        yCoord = *(s16 *)entityBase;
    yWork = yCoord * 3 + yOffset - yOffset + hold5 - hold5 + hold6 - hold6;
    yWork = (u16)yWork;
    ipWork = yWork;
    x = xWork >> 16;
    width = desc->width;
    yWork = desc->height;
    height = yWork;
    srcBase = desc->src;
    flags = *flagPtr >> 4;

    {
        register u32 one asm("r1");
        u32 flagBit;

        one = 1;
        flagBit = flags;
        flagBit &= one;
        dst = (u16 *)(0x80 << 18);
        if (flagBit)
            dst = (u16 *)0x02010000;
    }

    state = (u16 *)0x030060A0;
    stride = state[13];
    dst += stride * ipWork + x;
    src = srcBase[1];
    row = 0;
    bank = flags;
    if (row < height) {
        ipWork = (u32)state;

        do {
            col = 0;
            nextRow = row + 1;
            if (col < width) {
                do {
                    *dst++ = *src++;
                    col++;
                } while (col < width);
            }
            {
                register u32 stride2 asm("r3");

                stride2 = ipWork;
                stride2 = ((struct BlitState_1288C *)stride2)->stride;
                stride2 -= width;
                dst += stride2;
            }
            row = (u8)nextRow;
        } while (row < height);
    }

    {
        register u32 one asm("r1");

        one = 1;
        if (bank & one) {
            flushSrc = (void *)0x02010000;
            flushDst = (void *)0x0600E800;
        } else {
            flushSrc = (void *)(0x80 << 18);
            flushDst = (void *)0x0600E000;
        }
    }
    {
        register u32 one asm("r0");

        one = 1;
        bank &= one;
    }
    sub_080100E4(bank, flushSrc, flushDst);
    {
        u8 *sentinel = (u8 *)0x030064C0;

        sentinel[10] = 0;
    }
}
