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
            gEntities_03003720[i + 14].status |= 8;
        }
        for (i = 0; i <= 0; i++) {
            gEntities_03003720[i + 16].status |= 8;
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
    u32 *dp;
    const u32 *sp;
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

extern void sub_0800696C(void *p, s32 bits);
extern u32 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_080066C4(void *base, u32 selector, u32 bit);
extern void sub_08020C78(u32 sound);
extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_317ED4[1];

void sub_0802ACB4(void)
{
    s16 tileX;
    s16 tileY;
    u8 i;

    tileX = (u16)(gEntities[2].x / 24);
    tileY = (u16)(gEntities[2].y / 24);

    sub_0800696C(&gIwram_6110, 2);

    if (tileX == 5 && tileY == 3) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 4) && (u8)sub_0800679C(&gIwram_6110, 5, 0)) {
            sub_080066C4(&gIwram_6110, 5, 0);
            sub_08020C78(0x75);
        }
    }
    if (tileX == 6 && tileY == 3) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 5) && (u8)sub_0800679C(&gIwram_6110, 5, 1)) {
            sub_080066C4(&gIwram_6110, 5, 1);
            sub_08020C78(0x75);
        }
    }
    if (tileX == 8 && tileY == 5) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 6) && (u8)sub_0800679C(&gIwram_6110, 5, 2)) {
            sub_080066C4(&gIwram_6110, 5, 2);
            sub_08020C78(0x75);
        }
    }
    if (tileX == 8 && tileY == 6) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 7) && (u8)sub_0800679C(&gIwram_6110, 5, 3)) {
            sub_080066C4(&gIwram_6110, 5, 3);
            sub_08020C78(0x75);
        }
    }
    if (tileX == 6 && tileY == 8) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 5) && (u8)sub_0800679C(&gIwram_6110, 5, 4)) {
            sub_080066C4(&gIwram_6110, 5, 4);
            sub_08020C78(0x75);
        }
    }
    if (tileX == 5 && tileY == 8) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 4) && (u8)sub_0800679C(&gIwram_6110, 5, 5)) {
            sub_080066C4(&gIwram_6110, 5, 5);
            sub_08020C78(0x75);
        }
    }
    if (tileX == 3 && tileY == 6) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 7) && (u8)sub_0800679C(&gIwram_6110, 5, 6)) {
            sub_080066C4(&gIwram_6110, 5, 6);
            sub_08020C78(0x75);
        }
    }
    if (tileX == 3 && tileY == 5) {
        if (!(u8)sub_0800679C(&gIwram_6110, 8, 6) && (u8)sub_0800679C(&gIwram_6110, 5, 7)) {
            sub_080066C4(&gIwram_6110, 5, 7);
            sub_08020C78(0x75);
        }
    }

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_317ED4[i], i + 2);
        i++;
    } while (i <= 0);

    sub_08020FE4(2, 2);
    sub_08005D10(2, 2);
}
