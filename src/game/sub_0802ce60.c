#include "game.h"
#include "iwram.h"
#include "types.h"

/* --- Entity2_Tick: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern int __divsi3(int num, int den);

extern void ModeControl_SetBit(void *base, s32 bit);
extern u32 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(void *base, u32 selector, u32 bit);
extern void CtrlFlags_SetBit(void *base, u32 selector, u32 bit);
extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void EntityMover_Tick(u8 idx);
extern void MotionDesc_Set(struct Entity *e, s8 sel, s8 a, s8 b);
extern void Sound_Play(u32 sound);
extern void Entity_Update(void *p);
extern void Entity_MoveToEntry(struct Entity *ent, u8 dir, s16 *e);

extern const u32 sLevelLayout_31813C[32];
extern u8 gIwram_3610;

void Entity2_Tick(void)
{
    struct Entity *e2 = &gEntities[2];
    u16 *valXp = (u16 *)((u8 *)e2 + 0xa82);
    u16 valX = *valXp;
    u16 *valYp = (u16 *)((u8 *)e2 + 0xa84);
    u16 valY = *valYp;
    s32 buf;

    ModeControl_SetBit(&gIwram_6110, 2);

    if ((u8)ModeControl_GetFlag(&gIwram_6110, 8, 1)) {
        ModeControl_ClearBit(&gIwram_6110, 8, 1);
        CtrlFlags_SetBit(&gIwram_6110, 8, 0);
        sub_080210A0(2, sLevelLayout_31813C, 0x10, 0x59, 0x41, 1, 3, 2);
        *valXp = ((const u16 *)sLevelLayout_31813C)[4];
        *valYp = ((const u16 *)sLevelLayout_31813C)[5] + 0x3a;
    }

    if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 0)) {
        goto ret;
    }

    EntityMover_Tick(2);
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
            CtrlFlags_SetBit(&gIwram_6110, 8, 2);
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
        MotionDesc_Set(e2, 0, 0, 0);
        e2->status |= 2;
        gIwram_6110.scenePhase--;
        CtrlFlags_SetBit(&gIwram_6110, 8, 3);
        if (gIwram_6110.scenePhase == 0) {
            goto snd0;
        }
        goto snd1;
    move:
        Entity_MoveToEntry(e2, 12, (s16 *)&buf);
        goto tail;
    case 4:
        if ((&gIwram_3610)[((s16 *)&buf)[1] * 14 + ((s16 *)&buf)[0]] != 0) {
            goto case4_move;
        }
        e2->field_1A = 0;
        MotionDesc_Set(e2, 0, 0, 0);
        e2->status |= 2;
        gIwram_6110.scenePhase--;
        CtrlFlags_SetBit(&gIwram_6110, 8, 3);
        if (gIwram_6110.scenePhase == 0) {
            goto snd0;
        }
        goto snd1;
    snd0:
        Sound_Play(0x69);
        goto tail;
    snd1:
        Sound_Play(0x7a);
        goto tail;
    case4_move:
        if ((s16)e2->x >= (s16)valX && (u16)e2->y == valY) {
            Entity_MoveToEntry(e2, 12, (s16 *)&buf);
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
    Entity_Update(e2);
}
#endif /* NON_MATCHING */
