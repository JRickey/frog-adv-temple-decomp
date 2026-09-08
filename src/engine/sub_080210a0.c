#include "entity_spawn.h"
#include "entity_motion.h"
#include "iwram.h"
#include "types.h"

extern void DirToMotion(u8 dir, s8 *outX, s8 *outY);

/* The u8/u16 stack parameters are what hoist field14/field16/matchKey/field17
 * into r6/r8/r9/r5 at entry: their SImode->QImode/HImode parm conversion drops
 * the REG_EQUIV stack-slot note, so the pseudos must be register-allocated
 * instead of re-read from [sp]. The `pool` local puts the gEntities pool load
 * before the index math (r4), which is what pushes `rec` up into sl. */
void Entity_InitSlotFromRecord(u16 idx, const SpawnRecord *rec, u16 flags, u8 kind, u16 field14, u8 field16,
                               u8 matchKey, u8 field17)
{
    u8 state = rec->state;
    struct Entity *pool = gEntities;
    struct Entity *entity = &pool[idx];
    s32 dir;
    s32 initDir;
    s8 deltaX;
    s8 deltaY;

    entity->status = flags;
    entity->x = rec->x;
    entity->y = rec->y;
    entity->kind = kind;
    entity->field_14 = field14;
    entity->field_16 = field16;
    entity->field_17 = field17;
    entity->actorId = matchKey;

    dir = (s8)(rec->head >> 8);
    initDir = 2;
    if (dir != 0)
        initDir = dir;
    entity->field_33 = initDir;
    entity->state = state;
    entity->status |= 2;

    DirToMotion(state, &deltaX, &deltaY);
    MotionDesc_Set(entity, rec->param, deltaX, deltaY);
}
