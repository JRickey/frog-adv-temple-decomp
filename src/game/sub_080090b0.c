#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Cache-invalidation helper.
 *
 * Converts a pair of signed sub-pixel coordinates at gIwram_3720+{2,4} to
 * tile/cell coordinates by dividing each by 24 (signed). If the resulting
 * (X, Y) differs from the previously-cached pair at gIwram_35E0+{8,0xA},
 * raises bit 0x40 in the flags halfword at gIwram_35E0+0x10 (via
 * PlayerFlags_Set) and stores the new pair as the cache key.
 *
 * PlayerFlags_Set(p, v) is a 3-instruction leaf: `(u16*)(p+16) |= (u16)v;`.
 *
 * `cached` is pinned to r1: the baserom reuses one register (r1) for both
 * cached-coord loads and emits `cmp cached, new` (cached operand first).
 * Without the pin agbcc lands the cached load in r0 and flips the cmp
 * operand order. The pin reproduces the baserom's single-register reuse
 * and compare ordering exactly.
 */

extern u16 PlayerFlags_Set(void *p, u16 v); /* OR-into-u16-at-offset-16 */

void Player_UpdateTileCache(void)
{
    register u16 cached asm("r1");
    u16 newX = (u16)(gEntities[0].x / 24);
    u16 newY = (u16)(gEntities[0].y / 24);

    cached = (u16)gIwram_35E0._field_8;
    if (cached == newX) {
        cached = (u16)gIwram_35E0._field_A;
        if (cached == newY)
            return;
    }

    PlayerFlags_Set(&gIwram_35E0, 64);
    gIwram_35E0._field_8 = newX;
    gIwram_35E0._field_A = newY;
}

extern void Entity_Init(struct Entity *p, u8 a, s16 b, s16 c, u8 d, u16 e, u8 f, u8 g, u8 h, u16 i);

void Player_InitEntity(u16 x, u16 y, u8 g, u8 h)
{
    Entity_Init(gEntities, 0, (s16)x, (s16)y, 3, 1, 0, g, h, 16);
}

extern void Entity_Update(void *p);

/* When the dispatch state at +0x1A is 0x23, normalise the flags halfword at
 * +0x34 before handing the record to Entity_Update:
 *   - bit 1 set       -> clear bit 15
 *   - else bit 15 set -> clear bit 15 and set bit 1
 *   - else            -> leave unchanged
 *
 * The address is anchored in r0 (the empty barrier blocks agbcc's
 * reg-equiv fold that would load it straight into the working register) and
 * copied to base in r2, matching the baserom's `ldr r0; adds r2, r0`. `f` is
 * pinned to r1 so the flag ANDs accumulate mask-first into the r0 scratch. */
void Player_NormalizeStatusAndUpdate(void)
{
    register struct Entity *src asm("r0") = gEntities;
    struct Entity *base;
    register u16 f asm("r1");

    asm("" : "+r"(src));
    base = src;

    if (base->field_1A != 0x23)
        goto do_call;

    f = base->status;
    if (f & 2) {
        base->status = f & 0x7fff;
        goto do_call;
    }
    if (!(f & 0x8000))
        goto do_call;
    base->status = (f & 0x7fff) | 2;

do_call:
    Entity_Update(base);
}
