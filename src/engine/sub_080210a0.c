#include "iwram.h"
#include "types.h"

/* The entity-pool slot written here is the canonical struct Entity (iwram.h).
 * SpawnRecord below is the distinct ROM spawn-record input format (NOT SpawnRec). */
typedef struct SpawnRecord {
    u8 _field_00;
    u8 _field_01;
    u8 state;
    u8 _pad03[5];
    u16 x;
    u16 y;
    s8 param;
} SpawnRecord;

extern void DirToMotion(u8 dir, s8 *outX, s8 *outY);
extern void MotionDesc_Set(struct Entity *e, s8 param, s8 deltaX, s8 deltaY);

void Entity_InitSlotFromRecord(u32 idx, const void *record, u32 flags, u32 kind, u32 field14, u32 field16, u32 matchKey,
                               u32 field17)
{
    register const volatile SpawnRecord *recVol asm("sl") = (const volatile SpawnRecord *)record;
    const SpawnRecord *rec;
    u32 base;
    u32 offset;
    u32 transfer;
    register u32 field14Reg asm("r6");
    register u32 field16Reg asm("r8");
    register u32 matchKeyReg asm("r9");
    register u32 field17Reg asm("r5");
    u32 idxReg;
    register const SpawnRecord *rec2 asm("r2");
    u32 flagMask;
    u16 oldFlags;
    u32 recHeadReg;
    register u32 byteScratch0 asm("r0");
    register u32 byteScratch1 asm("r1");
    register const u8 *paramRec asm("r2");
    s32 param;
    struct Entity *entity;
    u8 state;
    s32 dir;
    s32 initDir;
    s8 deltaX;
    s8 deltaY;

    field14Reg = field14;
    transfer = field16;
    field16Reg = transfer;
    transfer = matchKey;
    matchKeyReg = transfer;
    field17Reg = field17;

    idxReg = (u16)idx;
    state = recVol->state;
    rec = (const SpawnRecord *)recVol;
    base = (u32)gEntities;
    offset = idxReg * sizeof(struct Entity);
    entity = (struct Entity *)(offset + base);
    entity->status = flags;
    rec2 = rec;
    entity->x = rec2->x;
    entity->y = rec2->y;
    entity->kind = kind;
    entity->field_14 = field14Reg;
    byteScratch0 = field16Reg;
    entity->field_16 = byteScratch0;
    entity->field_17 = field17Reg;
    byteScratch1 = matchKeyReg;
    entity->actorId = byteScratch1;

    recHeadReg = *(const u16 *)rec2;
    byteScratch0 = recHeadReg << 16;
    dir = (s32)byteScratch0 >> 24;
    initDir = 2;
    if (dir != 0)
        initDir = dir;
    entity->field_33 = initDir;

    byteScratch0 = state;
    entity->state = byteScratch0;
    flagMask = 2;
    oldFlags = entity->status;
    entity->status = flagMask | oldFlags;

    DirToMotion(state, &deltaX, &deltaY);
    paramRec = (const u8 *)recVol;
    param = *(const s8 *)(paramRec + 12);
    MotionDesc_Set(entity, param, deltaX, deltaY);
}
