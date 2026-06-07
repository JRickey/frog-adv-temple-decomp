#ifndef GUARD_ENTITY_H
#define GUARD_ENTITY_H

#include "types.h"

/* ROM hitbox/collision-point descriptor. One per entity shape; the dispatch
 * tables in entity_dispatch.c hand these to the collision-probe routines in
 * src/engine. */
typedef struct EntityHitbox {
    u32 count;  /* +0x00 -- 1..0x30 (consumer reads as u8) */
    u32 points; /* +0x04 -- const s16* into 0x082f9xxx..0x082faxxx */
    u32 flags;  /* +0x08 -- bit-packed (low byte = size class, 0x10000 = extended) */
} EntityHitbox;

#endif /* GUARD_ENTITY_H */
