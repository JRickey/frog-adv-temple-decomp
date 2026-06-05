#include "types.h"

struct BlitState_15B6C {
    u8 _pad00[26];
    u16 stride;
};

struct BlitSource_15B6C {
    u8 _pad00[12];
    const u16 *tiles;
    u8 _pad10[32];
    u16 srcStride;
};

void sub_08015B6C(u8 mode, s16 dstX, s16 dstY, u8 widthArg, u8 heightArg, struct BlitSource_15B6C *src)
{
    register struct BlitSource_15B6C *srcp asm("r8");
    register u16 *dst asm("r6");
    const u16 *srcData;
    register u32 row asm("r0");
    register u32 r1slot asm("r1");
    register u32 width asm("r5");
    register u32 height asm("r4");
    register u32 dyh asm("ip");
    register struct BlitState_15B6C *loopState asm("r9");
    u8 col;
    register u16 dstStride asm("r3");
    u32 scratch2;
    register s32 dx asm("r2");

    srcp = src;
    mode = (u8)(mode + ((u32)srcp - (u32)srcp));
    r1slot = (u16)(dstX + ((u32)srcp - (u32)srcp));
    dyh = (u16)dstY;
    width = (u8)(widthArg + ((u32)srcp - (u32)srcp));
    height = (u8)(heightArg + ((u32)srcp - (u32)srcp));

    switch (mode) {
    case 0:
        dst = (u16 *)(0x80 << 18);
        break;
    case 1:
        dst = (u16 *)0x02010000;
        break;
    case 2:
        dst = (u16 *)0x02020000;
        break;
    }

    row = r1slot << 16;
    dx = (s32)row >> 16;
    {
        register u32 earlyScratch asm("r7");

        earlyScratch = dyh;
        row = earlyScratch << 16;
        row = (s32)row >> 16;
    }
    r1slot = 0x030060A0;
    dstStride = ((struct BlitState_15B6C *)r1slot)->stride;
    row *= dstStride;
    row = dx + row;
    dst += row;

    scratch2 = (u32)srcp;
    srcData = *(const u16 **)(scratch2 + 12);
    row = 0;
    loopState = (struct BlitState_15B6C *)r1slot;
    if (row < height) {
        do {
            col = 0;
            r1slot = row + 1 + scratch2 - scratch2;
            if (col < width) {
                do {
                    *dst++ = *srcData++;
                    col = (u8)(col + 1);
                } while (col < width);
            }

            dx = (u32)loopState;
            dx = ((struct BlitState_15B6C *)dx)->stride;
            dst += dx - width + scratch2 - scratch2;
            scratch2 = (u32)srcp;
            scratch2 = ((struct BlitSource_15B6C *)scratch2)->srcStride;
            srcData += scratch2 - width;
            row = (u8)r1slot;
        } while (row < height);
    }
}
