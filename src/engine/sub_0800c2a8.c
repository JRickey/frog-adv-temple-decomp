#include "types.h"

/* Copies one (x, y) hitbox point — the 4-byte pair at index `point` of
 * sEntityHitboxTable[type].points — into *out.
 *
 * Returns `out`: the baserom epilogue is `pop {r1}; bx r1`, keeping r0 the
 * live return register. A void variant frees r0 and agbcc reuses it for the
 * bx scratch (`pop {r0}; bx r0`) — 2 bytes off. Returning `out` pins r0. */

typedef struct EntityHitbox {
    u32 count;
    u32 points;
    u32 flags;
} EntityHitbox;

extern const EntityHitbox sEntityHitboxTable[];

u32 *sub_0800C2A8(u32 *out, s8 type, s8 point)
{
    *out = ((const u32 *)sEntityHitboxTable[type].points)[point];
    return out;
}
