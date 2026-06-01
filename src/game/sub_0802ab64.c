#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void sub_08021140(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

extern void sub_0802A8FC(void);
extern void sub_0802A9FC(void);
extern void sub_0802A4A4(void);
extern void sub_0802A394(void);
extern void sub_0802AB14(void);
extern void sub_0802A538(void);
extern void sub_0802AAE8(void);
extern void sub_0802AAEC(void);

extern const void *const sLevelLayoutPtrs_317E6C[2];
extern const u32 sLevelLayout_317DDC[4];
extern const u32 sLevelLayout_317E74[12];

struct Entity {
    u8 _pad00[0x34];
    u16 _field_34; /* +0x34: flag halfword */
    u8 _pad36[2];
};

extern struct Entity gEntities_03003720[];

void sub_0802AB64(void)
{
    u8 i;

    for (i = 0; i < 2; i++) {
        sub_080210A0(i + 17, sLevelLayoutPtrs_317E6C[i], 0, 27, ((i & 1) << 4) | 0x161, 6, 3, 3);
    }
}

void sub_0802ABB0(void)
{
    sub_08021140(12, sLevelLayout_317DDC, 16, 0x52, 0x101, 3, 0);
}

void sub_0802ABDC(void)
{
    s8 i;

    sub_0802A8FC();
    sub_0802A9FC();

    if (gIwram_6110.gateByte <= 1) {
        sub_0802A4A4();
        sub_0802A394();
    } else {
        for (i = 0; i <= 1; i++) {
            gEntities_03003720[i + 14]._field_34 |= 8;
        }
        for (i = 0; i <= 0; i++) {
            gEntities_03003720[i + 16]._field_34 |= 8;
        }
    }

    sub_0802AB14();
    sub_0802A538();
}

void sub_0802AC60(void)
{
    u8 i;
    u8 *dst;
    const u8 *src;
    u8 *base;
    u32 off;
    register u32 *dp asm("r2");
    register const u32 *sp asm("r0");
    u32 v0;
    u32 v1;

    i = 0;
    dst = (u8 *)0x03003570;
    src = (const u8 *)sLevelLayout_317E74;
    for (; i < 6; i++) {
        dp = (u32 *)((u32)i * 8 + (u32)dst);
        sp = (const u32 *)((u32)i * 8 + (u32)src);
        v1 = sp[1];
        v0 = sp[0];
        dp[1] = v0;
        dp[2] = v1;
    }
    sub_0802AAE8();
    sub_0802AAEC();
    sub_0802ABB0();
    base = (u8 *)gEntities_03003720;
    off = 0x0b48;
    *(u32 *)(base + off) = gGameStuff._unk00;
}
