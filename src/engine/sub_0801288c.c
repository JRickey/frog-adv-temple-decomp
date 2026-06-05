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
    register u32 r0Work asm("r0");
    register u32 hold5 asm("r5");
    register u32 hold6 asm("r6");
    s32 xCoord;
    s32 yCoord;
    register u32 r2Work asm("r2");
    u32 yWork;
    register u32 x asm("r8");
    register u32 ipWork asm("ip");
    u32 flags;
    u32 width;
    register u32 height asm("r9");
    const u16 *const *srcBase;
    register const u16 *r1Work asm("r1");
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
    r2Work = xCoord * 3 + xOffset - xOffset + hold5 - hold5 + hold6 - hold6;
    r2Work <<= 16;
    r0Work = 0x694;
    entityBase -= -r0Work;
    /* Keep the r0 scratch live through the signed load for matching. */
    if (r0Work)
        yCoord = *(s16 *)entityBase;
    else
        yCoord = *(s16 *)entityBase;
    yWork = yCoord * 3 + r0Work - r0Work + hold5 - hold5 + hold6 - hold6;
    yWork = (u16)yWork;
    ipWork = yWork;
    x = r2Work >> 16;
    width = desc->width;
    yWork = desc->height;
    height = yWork;
    srcBase = desc->src;
    flags = *flagPtr >> 4;

    {
        u32 flagBit;

        r1Work = (const u16 *)1;
        flagBit = flags;
        flagBit &= (u32)r1Work;
        r2Work = 0x80 << 18;
        if (flagBit)
            r2Work = 0x02010000;
    }

    state = (u16 *)0x030060A0;
    stride = state[13];
    r2Work += (stride * ipWork + x) << 1;
    r1Work = srcBase[1];
    row = 0;
    bank = flags;
    if (row < height) {
        ipWork = (u32)state;

        do {
            col = 0;
            nextRow = row + 1;
            if (col < width) {
                do {
                    *(u16 *)r2Work = *r1Work++;
                    r2Work += 2;
                    col++;
                } while (col < width);
            }
            {
                register u32 stride2 asm("r3");
                u32 strideAdvance;

                stride2 = ipWork;
                stride2 = ((struct BlitState_1288C *)stride2)->stride;
                strideAdvance = stride2 - width;
                strideAdvance <<= 1;
                r2Work += strideAdvance;
            }
            row = (u8)nextRow;
        } while (row < height);
    }

    {
        r1Work = (const u16 *)1;
        if (bank & (u32)r1Work) {
            flushSrc = (void *)0x02010000;
            flushDst = (void *)0x0600E800;
        } else {
            flushSrc = (void *)(0x80 << 18);
            flushDst = (void *)0x0600E000;
        }
    }
    {
        r0Work = 1;
        bank &= r0Work;
    }
    sub_080100E4(bank, flushSrc, flushDst);
    {
        u8 *sentinel = (u8 *)0x030064C0;

        sentinel[10] = 0;
    }
}
