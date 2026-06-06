#include "game.h"
#include "iwram.h"
#include "types.h"

extern void EnemyLayout_Reset(void);
extern u32 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void CtrlFlags_SetBit(u8 *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(u8 *base, u32 selector, u32 bit);
extern void Sound_Play(u32 arg);
extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);

extern const u32 sLevelLayout_31807C[12];
extern const u32 sLevelLayout_3180AC[12];
extern const u32 sLevelLayout_3180DC[12];
extern const u32 sLevelLayout_31810C[12];

void EnemySpawn_Tick(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;
    u8 *base3720;
    u8 *p;
    u8 spawnMask;

    if ((u8)ModeControl_GetFlag(base6110, 3, 1)) {
        EnemyLayout_Reset();
        CtrlFlags_SetBit(base6110, 3, 7);
        ModeControl_ClearBit(base6110, 3, 1);
        /* The empty asm fence reloads the gEntities base into a scratch
         * register here instead of caching it across the function, matching
         * the baserom's separate `ldr =0x03003720` at each store site. */
        p = (u8 *)gEntities;
        asm("" : "+r"(p));
        *(u32 *)(p + 0xd4) = gGameStuff._unk00;
    }

    if ((u8)ModeControl_GetFlag(base6110, 3, 7) == 0)
        return;

    /* The base3720 load is folded into the condition so it materializes after
     * the gGameStuff load, matching the baserom's operand order in the
     * subtraction. */
    if (gGameStuff._unk00 - *(u32 *)((base3720 = (u8 *)gEntities) + 0xd4) > 240) {
        s32 i;

        CtrlFlags_SetBit(base6110, 3, 2);

        for (i = 3; i <= 7; i++) {
            ((struct Entity *)base3720)[i].status |= 8;
        }

        base6110 = (u8 *)&gIwram_6110;
        ModeControl_ClearBit(base6110, 3, 7);
        ModeControl_ClearBit(base6110, 3, 2);
        Sound_Play(106);
        CtrlFlags_SetBit(base6110, 3, 9);
        /* Same scratch-reload fence as above: the baserom re-materializes the
         * gEntities base for this store rather than reusing base3720. */
        p = (u8 *)gEntities;
        asm("" : "+r"(p));
        *(u32 *)(p + 0xb48) = gGameStuff._unk00;
        return;
    }

    spawnMask = base6110[0x33];
    switch (spawnMask) {
    case 0:
        Entity_WalkCompactRecords(3, sLevelLayout_31807C, 4, base6110, spawnMask);
        break;
    case 1:
        Entity_WalkCompactRecords(3, sLevelLayout_3180AC, 4, base6110, 0);
        break;
    case 2:
        Entity_WalkCompactRecords(3, sLevelLayout_3180DC, 4, base6110, 0);
        break;
    case 3:
        Entity_WalkCompactRecords(3, sLevelLayout_31810C, 4, base6110, 0);
        break;
    }
}

/* --- Entity22_Update: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

struct MotionDesc {
    u8 _pad00[0x2a];
    u8 sel;
    u8 _pad2b[5];
    u8 dx;
    u8 dy;
    u8 mode;
};

extern void MotionDesc_Set(struct MotionDesc *m, s8 sel, s8 a, s8 b);
extern void DirToMotion(u8 dir, s8 *outX, s8 *outY);
extern void EntityMover_Tick(u8 idx);
extern void Entity_Update(void *p);

void Entity22_Update(void)
{
    struct Entity *entity = &gEntities[22];
    s8 out[2];
    u8 nextState;

    switch (entity->field_1A) {
    case 0:
        MotionDesc_Set((struct MotionDesc *)entity, 0, 0, 0);
        if ((entity->status & 0x8000) == 0)
            goto done;

        entity->field_1A = *((u8 *)entity + 0x6aa);
        entity->status |= 2;
        {
            u8 dir = entity->field_1A;
            register s8 *outY asm("r4") = &out[1];
            DirToMotion(dir, &out[0], outY);
            MotionDesc_Set((struct MotionDesc *)entity, 2, out[0], *outY);
        }
        entity->status &= 0x7fff;
        goto done;

    case 3: {
        u16 status;
        EntityMover_Tick(22);
        status = entity->status;
        if (status & 0x8000) {
            /* r0 pin threads the (2|status)&0x7fff accumulator through r0,
               matching `movs r0,#2; orrs r0,r1; ldr r1,=0x7fff; ands r0,r1`. */
            register u16 t asm("r0");
            t = 2;
            t |= status;
            t &= 0x7fff;
            entity->status = t;
        }

        if (entity->x > 0x77)
            goto done;
        nextState = 4;
        break;
    }

    case 4: {
        u16 status;
        EntityMover_Tick(22);
        status = entity->status;
        if (status & 0x8000) {
            register u16 t asm("r0");
            t = 2;
            t |= status;
            t &= 0x7fff;
            entity->status = t;
        }

        if (entity->x <= 0xc0)
            goto done;
        nextState = 3;
        break;
    }

    default:
        goto done;
    }

    entity->field_1A = nextState;
    *((u8 *)entity + 0x6aa) = nextState;
    {
        u8 dir = entity->field_1A;
        register s8 *outY asm("r4") = &out[1];
        DirToMotion(dir, &out[0], outY);
        MotionDesc_Set((struct MotionDesc *)entity, 2, out[0], *outY);
    }
    entity->status |= 2;

done:
    Entity_Update(entity);
}
#endif /* NON_MATCHING */
