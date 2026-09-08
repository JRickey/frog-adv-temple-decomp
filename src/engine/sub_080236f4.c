#include "macros.h"
#include "entity_motion.h"
#include "sound.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern void Entity_InitFromLayout(void *obj, u8 idx);

extern const u32 sLevelLayoutPtrs_312C98[5];
extern const u32 sLevelLayoutPtrs_312D4C[5];

void sub_080236F4(void)
{
    u8 i;
    struct Entity *e;
    struct Entity *e2;
    struct Entity *base;
    u8 state;
    u8 state2;
    u16 status;
    u16 status0;
    u16 status1;
    u16 status2;
    /* Every pin below compensates a regmove/cse tie-direction delta between pret
       agbcc and Konami's later SDK snapshot — toolchain workarounds, not source
       shapes; each is individually load-bearing. See docs/codegen-notes.md
       "Konami's compiler is a THIRD SDK snapshot". */
    /* r1 pin: regmove's backward pass copies the first commutative operand to hit
       an obstacle but skips hard regs, so the const `two` gets copied at the
       2&status3 test the way the baserom does. */
    register u32 status3 asm("r1");
    u32 maskHi;
    u32 maskHi2;
    u32 mask8;

    if (gEntities[0].y > 0x101)
        return;

    i = 0;
    maskHi = 0x8000;
    do {
        u16 slotIdx = i + 0x67;
        u16 slot;

        e = &gEntities[slotIdx];
        state = e->state;
        slot = slotIdx;
        switch (state) {
        case 0:
            status0 = e->status;
            if ((2 & status0) == 0 && (maskHi & status0) != 0) {
                u16 t0;
                do {
                    t0 = 2 | status0;
                } while (0);
                e->status = t0 & 0x7FFF;
            }
            break;
        case 3: {
            /* `two` is also passed to the slot-init calls below; that liveness keeps
               it un-tieable so regmove copies it into the test temp instead. */
            u32 two;
            status3 = e->status;
            two = 2;
            if ((two & status3) != 0)
                break;
            if ((maskHi & status3) == 0)
                break;
            if (i == 0)
                Entity_InitSlotFromRecord(0x68, (const void *)sLevelLayoutPtrs_312C98[1], 16, 28, 0x211, 10, state,
                                          two);
            else if (i == 1)
                Entity_InitSlotFromRecord(0x69, (const void *)sLevelLayoutPtrs_312C98[2], 16, 28, 0x231, 10, state,
                                          two);
            Entity_InitSlotFromRecord(i + 0x6C, (const void *)sLevelLayoutPtrs_312D4C[i], 16, 29,
                                      ((((i % 5u) << 24) >> 4) + 0x02910000) >> 16, 11, 3, 2);
            gEntities[slot].state = 0;
            gEntities[slot].status |= 2;
            Sound_PlayNearEntity((struct Entity *)(i * 56 + 0x03004DA8), 0x24, 15, 5);
            break;
        }
        case 1:
            status1 = e->status;
            if ((2 & status1) == 0 && (maskHi & status1) != 0) {
                u16 t1;
                do {
                    t1 = 2 | status1;
                } while (0);
                e->status = t1 & 0x7FFF;
            }
            break;
        case 2:
            status2 = e->status;
            if ((status2 & 2) != 0)
                break;
            if ((status2 & maskHi) == 0)
                break;
            Entity_InitSlotFromRecord(i + 0x6C, (const void *)sLevelLayoutPtrs_312D4C[i], 16, 29,
                                      ((((i % 5u) << 24) >> 4) + 0x02910000) >> 16, 11, 3, 3);
            e->state = 1;
            status2 = *(volatile u16 *)&e->status;
            e->status = (status2 | 2) & 0x7FFF;
            if (i == 4)
                Sound_PlayNearEntity((struct Entity *)((s32)gEntities + 0x1768), 0x24, 4, 4);
            break;
        }
        ModeControl_SetBit(&gIwram_6110, slot);
        i++;
    } while (i <= 4);

    Entity_AdvanceAnimFrames(0x67, 0x69);
    Entity_AdvanceAnimFrames(0x6A, 0x6B);

    i = 0;
    base = gEntities;
    mask8 = 8;
    maskHi2 = 0x8000;
    do {
        u16 slotIdx = i + 0x6C;
        u16 slot;

        e2 = (struct Entity *)(slotIdx * 56 + (s32)base);
        status = e2->status;
        {
            u16 t8 = 8 & status;

            slot = slotIdx;
            if (t8 == 0) {
                state2 = e2->state;
                switch (state2) {
                case 0:
                    if ((2 & status) != 0)
                        break;
                    {
                        /* r0 pin: status dies here, so regmove's fwd pass would tie it
                           into the result; a hard-reg dst makes regmove skip the insn. */
                        register u32 hit asm("r0");
                        hit = maskHi2 & status;
                        if (hit == 0)
                            break;
                    }
                    {
                        struct Entity *prev = (struct Entity *)((i + 0x67) * 56 + (s32)base);
                        prev->status |= 2;
                        prev->state = 3;
                    }
                    e2->status = mask8 | e2->status;
                    break;
                case 3: {
                    /* r5 pin: a hard reg is opaque to cse's const tracking and skipped
                       by regmove, so the textual operand order at the | sites survives
                       to reload, which ties them as the baserom does; r5 = the only
                       callee-saved reg free across the MotionDesc_Set call. */
                    register u32 two asm("r5");
                    int t;

                    two = 2;
                    t = 2 & status;
                    if (t != 0)
                        break;
                    if (e2->x <= 0x38B) {
                        u32 tmid;
                        e2->state = t;
                        do {
                            tmid = two | status;
                        } while (0);
                        e2->status = tmid;
                        {
                            u32 mdOff = 0x17A0;
                            MotionDesc_Set((void *)(i * 56 + ((s32)base + mdOff)), 0, 0, 0);
                        }
                    }
                    if ((maskHi2 & e2->status) == 0)
                        break;
                    {
                        u32 ttail;
                        do {
                            ttail = e2->status | two;
                        } while (0);
                        e2->status = ttail & 0x7FFF;
                    }
                    break;
                }
                case 1:
                    if ((2 & e2->status) != 0)
                        break;
                    {
                        /* r0 pin: same regmove fwd-pass tie as case 0 — status dies here. */
                        register u32 hit asm("r0");
                        hit = maskHi2 & e2->status;
                        if (hit == 0)
                            break;
                    }
                    {
                        struct Entity *prev = (struct Entity *)((i + 0x67) * 56 + (s32)base);
                        prev->status |= 2;
                        prev->state = 2;
                    }
                    e2->status = mask8 | e2->status;
                    break;
                case 2: {
                    /* r1 pin: same cse/regmove opacity as the case-3 r5 pin; `two` is
                       dead before the call on both paths, so a caller-saved reg is safe. */
                    register u32 two asm("r1");

                    two = 2;
                    if ((e2->status & 2) != 0)
                        break;
                    if (e2->y > 0x7C) {
                        /* r0 pin: `two` dies at the |, so the allocator would reuse r1
                           and fold the copy away; the baserom builds the result in r0. */
                        register u32 ty asm("r0");
                        e2->state = 1;
                        do {
                            ty = two | status;
                        } while (0);
                        e2->status = ty;
                        {
                            u32 mdOff = 0x17A0;
                            MotionDesc_Set((void *)(i * 56 + ((s32)base + mdOff)), 0, 0, 0);
                        }
                        break;
                    }
                    if ((maskHi2 & e2->status) == 0)
                        break;
                    {
                        u32 ttail;
                        do {
                            ttail = e2->status | two;
                        } while (0);
                        e2->status = ttail & 0x7FFF;
                    }
                    break;
                }
                }
                ModeControl_SetBit(&gIwram_6110, slot);
            }
        }
        i++;
    } while (i <= 4);

    Entity_InitFromLayout((void *)sLevelLayoutPtrs_312D4C[0], 0x6C);
    Entity_InitFromLayout((void *)sLevelLayoutPtrs_312D4C[1], 0x6D);
    Entity_InitFromLayout((void *)sLevelLayoutPtrs_312D4C[2], 0x6E);
    Entity_UpdateMovers(0x6F, 0x70);
    Entity_AdvanceAnimFrames(0x6F, 0x70);
}
