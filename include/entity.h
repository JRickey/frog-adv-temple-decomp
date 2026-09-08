#ifndef GUARD_ENTITY_H
#define GUARD_ENTITY_H

#include "types.h"

/* Waypoint record: two tile-coord fields (a=x, c=y as u16) and two signed
 * delta/step fields (b, d as s16).  Five files share this layout; the two
 * u16-b/d files cast (s16) at compare sites, which is byte-neutral when the
 * underlying field is already s16. */
typedef struct {
    u16 a;
    s16 b;
    u16 c;
    s16 d;
} Entry;

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

/* Active collision slot in the hitbox-slot table (8 bytes per slot).
 * `flags` holds the gGameStuff._unk00 tick of the last phase change and
 * `state` the reveal-animation frame (see Entity_UpdateHitboxWithTile). */
typedef struct CollisionSlot {
    u32 flags;
    u8 active; /* HITSLOT_* phase */
    u8 touched;
    u8 state;
    u8 _pad7;
} CollisionSlot;

enum {
    HITSLOT_IDLE = 0,
    HITSLOT_REVEALING = 1,
    HITSLOT_REVEALED = 2,
};

/* Signed 2-D point (x, y) extracted from a hitbox descriptor's points array. */
typedef struct EntityHitboxPoint {
    s16 x;
    s16 y;
} EntityHitboxPoint;

/* Cast-overlay on the ROM hitbox table: the first 10 bytes of each entry
 * viewed as flag bytes.  sub_0800a83c reads both flag fields; sub_0800af50
 * only uses primaryFlags but the layout must stay identical. */
typedef struct EntityHitboxFlagBytes {
    u32 count;
    u32 points;
    u8 primaryFlags;
    u8 alternateFlags;
    u8 _padA[2];
} EntityHitboxFlagBytes;

/* Cast-overlay on the ROM hitbox table with the byte-wide fields the hit-slot
 * updaters read: the signed point count and the three flag bytes at +8..+10. */
typedef struct EntityHitboxBytes {
    s8 count; /* +0 */
    u8 _pad01[3];
    const EntityHitboxPoint *points; /* +4 */
    u8 primaryFlags;                 /* +8 */
    u8 alternateFlags;               /* +9 */
    u8 blitBank;                     /* +10: bank argument for BlitFrameCell */
    u8 _padB;
} EntityHitboxBytes;

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
    u8 _pad1;
    u16 sortY;
    u16 next;
    u8 _pad6[2];
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
void Entity_UpdateHitboxWithTile(CollisionSlot *slots, u64 *mask, s8 type);

void Entity_CollisionProbe(CollisionSlot *slots, u64 *mask);

void Entity_UpdateMovers(s32 start, s32 end);

void EntityMover_Tick(u8 arg);

void Entity_FollowPath(const void *path, s32 slot);

void EntityParam_Apply(u32 arg);

u32 Entity_IsInProximity(s32 idx);

void Entity_WalkCompactRecords(u8 baseSlot, const void *pCount, u8 kind, void *unused, u8 bitBase);

void Entity_RunScript(u32 id, void *obj);

/* arg1 (mask) is a pointer to a u64 bit-field; void* avoids pointer-type
 * drift across callers that receive it as a generic u32/void* parameter. */
void Entity_ActivateHitSlot(void *ent, void *mask, u8 kind, u8 tile);

void Entity_SpawnFromRecord(s8 id);

void EntityScript_Advance(s8 a, s8 b, s32 c);

s8 EntityHitbox_FindPoint(s8 type, s16 x, s16 y);

/* Grid selectors and the alternate-flags selector consume only their low byte. */
void EntityHitbox_RegisterGridPoints(u8 type, u32 gridId, u32 gridPlane, u32 useAlternateFlags);

#endif /* GUARD_ENTITY_H */
