#ifndef GUARD_ENTITY_H
#define GUARD_ENTITY_H

#include "types.h"

/* Spawn record: two tile-coord halfwords + 5 config bytes (8 bytes + pad → 9 total, stride varies). */
struct SpawnRec {
    s16 _h0;
    s16 _h2;
    u8 _b4;
    u8 _b5;
    u8 _b6;
    u8 _b7;
    u8 _b8;
};

/* 8-byte hit-slot entry in the entity hit-slot array (base + idx*8). */
struct EntryB8A8 {
    u32 _field_0;
    u8 _field_4;
    u8 _field_5;
    u8 _pad6[2];
};

/* Active collision slot in the hitbox-slot table (8 bytes per slot). */
typedef struct CollisionSlot {
    u32 flags;
    u8 active;
    u8 touched;
    u8 state;
    u8 _pad7;
} CollisionSlot;

/* Signed 2-D point (x, y) extracted from a hitbox descriptor's points array. */
typedef struct EntityHitboxPoint {
    s16 x;
    s16 y;
} EntityHitboxPoint;

/* ROM hitbox/collision-point descriptor. One per entity shape; the dispatch
 * tables in entity_dispatch.c hand these to the collision-probe routines in
 * src/engine. */
typedef struct EntityHitbox {
    u32 count;  /* +0x00 -- 1..0x30 (consumer reads as u8) */
    u32 points; /* +0x04 -- const s16* into 0x082f9xxx..0x082faxxx */
    u32 flags;  /* +0x08 -- bit-packed (low byte = size class, 0x10000 = extended) */
} EntityHitbox;

/* Element of the active-entity index table at 0x03006160 (8-byte stride).
 * `id` indexes the entity pool gEntities[] (stride 0x38); the asm reads it
 * unsigned (ldrb). */
typedef struct IndexEntry {
    u8 id;
    u8 _pad[7];
} IndexEntry;

/* An entity record (gEntities slot) viewed only through the four fields
 * MotionDesc_Set writes (sel @0x2A, dx/dy/mode @0x30-0x32). Kept as a dedicated
 * typed view rather than a cast off the entity so each store derives its
 * address from the base pointer afresh, matching the baserom (a single Entity*
 * would let agbcc CSE-fold the base+offset and diverge). */
struct MotionDesc {
    u8 _pad00[0x2a];
    u8 sel;
    u8 _pad2b[5];
    u8 dx;
    u8 dy;
    u8 mode;
};

void Entity_UpdateHitboxSlots(void *slotsArg, void *outArg, s8 type);

void Entity_UpdateMovers(s32 start, s32 end);

void EntityMover_Tick(u8 arg);

void EntityParam_Apply(u32 arg);

u32 Entity_IsInProximity(s32 idx);

void Entity_WalkCompactRecords(u8 baseSlot, const void *pCount, u8 kind, void *unused, u8 bitBase);

void Entity_RunScript(u32 id, void *obj);

/* arg1 (mask) is a pointer to a u64 bit-field; void* avoids pointer-type
 * drift across callers that receive it as a generic u32/void* parameter. */
void Entity_ActivateHitSlot(void *ent, void *mask, u8 kind, u8 tile);

void Entity_SpawnFromRecord(s8 id);

void EntityScript_Advance(s8 a, s8 b, s32 c);

#endif /* GUARD_ENTITY_H */
