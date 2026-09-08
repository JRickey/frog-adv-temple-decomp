#ifndef GUARD_ENTITY_SPAWN_H
#define GUARD_ENTITY_SPAWN_H

#include "types.h"

/* ROM input for Entity_InitSlotFromRecord; distinct from SpawnRec. */
typedef struct SpawnRecord {
    u16 head;
    u8 state;
    u8 _pad03[5];
    u16 x;
    u16 y;
    s8 param;
} SpawnRecord;

void Entity_InitSlotFromRecord(u16 idx, const SpawnRecord *rec, u16 flags, u8 kind, u16 field14, u8 field16,
                               u8 matchKey, u8 field17);
void LevelLayout_SpawnGroup317A4C(void);

#endif /* GUARD_ENTITY_SPAWN_H */
