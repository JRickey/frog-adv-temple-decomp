#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern void sub_0802B3B0(void);
extern void sub_0802B4B8(void);
extern void sub_0800DA10(void);
extern void sub_0800D1F8(void);

extern const u32 sLevelLayout_317FD0[];

void sub_0802BC24(void)
{
    sub_08021140(0x17, sLevelLayout_317FD0, 0x10, 0x57, 0x89, 3, 0);
}

void sub_0802BC4C(void)
{
    u8 i;

    for (i = 0; i <= 3; i++) {
        register u32 off asm("r0");
        u32 *dst;
        const u32 *src;
        register u32 hi asm("r1");
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
