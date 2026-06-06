#include "game.h"
#include "iwram.h"
#include "types.h"

/* --- sub_0802CE60: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern int __divsi3(int num, int den);

extern void sub_0800696C(void *base, s32 bit);
extern u32 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_080066C4(void *base, u32 selector, u32 bit);
extern void sub_08006600(void *base, u32 selector, u32 bit);
extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void sub_08020F3C(u8 idx);
extern void sub_0800A580(struct Entity *e, s8 sel, s8 a, s8 b);
extern void sub_08020C78(u32 sound);
extern void sub_080059C4(void *p);
extern void sub_0802CDD0(struct Entity *ent, u8 dir, s16 *e);

extern const u32 sLevelLayout_31813C[32];
extern u8 gIwram_3610;

void sub_0802CE60(void)
{
    struct Entity *e2 = &gEntities[2];
    u16 *valXp = (u16 *)((u8 *)e2 + 0xa82);
    u16 valX = *valXp;
    u16 *valYp = (u16 *)((u8 *)e2 + 0xa84);
    u16 valY = *valYp;
    s32 buf;

    sub_0800696C(&gIwram_6110, 2);

    if ((u8)sub_0800679C(&gIwram_6110, 8, 1)) {
        sub_080066C4(&gIwram_6110, 8, 1);
        sub_08006600(&gIwram_6110, 8, 0);
        sub_080210A0(2, sLevelLayout_31813C, 0x10, 0x59, 0x41, 1, 3, 2);
        *valXp = ((const u16 *)sLevelLayout_31813C)[4];
        *valYp = ((const u16 *)sLevelLayout_31813C)[5] + 0x3a;
    }

    if (!(u8)sub_0800679C(&gIwram_6110, 8, 0)) {
        goto ret;
    }

    sub_08020F3C(2);
    {
        register s32 packed asm("r4");
        u16 tx = __divsi3((s16)e2->x, 24);
        packed = buf & 0xFFFF0000;
        packed |= tx;
        buf = packed;
        {
            s32 ty = __divsi3((s16)e2->y + 14, 24);
            packed &= 0x0000FFFF;
            packed |= ty << 16;
            buf = packed;
        }
    }

    switch (e2->field_1A) {
    case 0:
        if (e2->status & 0x8000) {
            sub_08006600(&gIwram_6110, 8, 2);
        }
        goto tail;
    case 1:
        if ((&gIwram_3610)[((s16 *)&buf)[1] * 14 + ((s16 *)&buf)[0]] == 0) {
            goto despawn;
        }
        if ((u16)e2->x == valX && (s16)e2->y <= (s16)valY) {
            goto move;
        }
        goto tail;
    case 2:
        if ((&gIwram_3610)[((s16 *)&buf)[1] * 14 + ((s16 *)&buf)[0]] == 0) {
            goto despawn;
        }
        if ((u16)e2->x == valX && (s16)e2->y >= (s16)valY) {
            goto move;
        }
        goto tail;
    case 3:
        if ((&gIwram_3610)[((s16 *)&buf)[1] * 14 + ((s16 *)&buf)[0]] == 0) {
            goto despawn;
        }
        if ((s16)e2->x <= (s16)valX && (u16)e2->y == valY) {
            goto move;
        }
        goto tail;
    despawn:
        e2->field_1A = 0;
        sub_0800A580(e2, 0, 0, 0);
        e2->status |= 2;
        gIwram_6110.scenePhase--;
        sub_08006600(&gIwram_6110, 8, 3);
        if (gIwram_6110.scenePhase == 0) {
            goto snd0;
        }
        goto snd1;
    move:
        sub_0802CDD0(e2, 12, (s16 *)&buf);
        goto tail;
    case 4:
        if ((&gIwram_3610)[((s16 *)&buf)[1] * 14 + ((s16 *)&buf)[0]] != 0) {
            goto case4_move;
        }
        e2->field_1A = 0;
        sub_0800A580(e2, 0, 0, 0);
        e2->status |= 2;
        gIwram_6110.scenePhase--;
        sub_08006600(&gIwram_6110, 8, 3);
        if (gIwram_6110.scenePhase == 0) {
            goto snd0;
        }
        goto snd1;
    snd0:
        sub_08020C78(0x69);
        goto tail;
    snd1:
        sub_08020C78(0x7a);
        goto tail;
    case4_move:
        if ((s16)e2->x >= (s16)valX && (u16)e2->y == valY) {
            sub_0802CDD0(e2, 12, (s16 *)&buf);
        }
        goto tail;
    default:
        goto tail;
    }

tail:
    if (e2->status & 0x8000) {
        if (gIwram_6110.scenePhase == 0) {
            e2->status |= 8;
        }
        e2->status |= 2;
        *(u16 *)((u8 *)gEntities + 0xA4) &= 0x7fff;
    }

ret:
    sub_080059C4(e2);
}
#endif /* NON_MATCHING */
