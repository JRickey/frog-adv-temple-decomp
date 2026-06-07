#include "entity.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Entity_ProbeDir — directional hit-test: probe a point 24px off the player
 * header in one of four cardinal directions against the active 56-byte entity
 * records, returning 1 if any record's axis-aligned box contains it.
 *
 * The probe point is built from the player header (record 0 at 0x03003720,
 * fields +2/+4) per the direction argument:
 *   1: ( header+2,        header+4 - 24 )
 *   2: ( header+2,        header+4 + 24 )
 *   4: ( header+2 - 24,   header+4      )
 *   8: ( header+2 + 24,   header+4      )
 * then matched against the same box test as Player_FindNearbyInteractable (record+1 must be 3
 * here, not 2), walking the active-entity index table at 0x03006160. */

extern struct Entity gEntities_03003720[];
extern struct IndexEntry gEntityIndex_03006160[];

u8 Entity_ProbeDir(u8 dir)
{
    s16 probeY;
    s16 probeX;
    s32 i;

    switch (dir) {
    case 1:
        probeY = gEntities_03003720[0].x;
        probeX = gEntities_03003720[0].y - 24;
        break;
    case 2:
        probeY = gEntities_03003720[0].x;
        probeX = gEntities_03003720[0].y + 24;
        break;
    case 4:
        probeY = gEntities_03003720[0].x - 24;
        probeX = gEntities_03003720[0].y;
        break;
    case 8:
        probeY = gEntities_03003720[0].x + 24;
        probeX = gEntities_03003720[0].y;
        break;
    }

    for (i = 0; i < gIwram_6110.liveCount; i++) {
        u8 id = gEntityIndex_03006160[i].id;
        struct Entity *e;
        u8 *ep;
        s16 left, right, top, bottom;

        if (id == 0)
            continue;

        /* Materialise the record-array base into ep before the id*0x38
         * offset so agbcc emits the base load ahead of the index multiply
         * (expr.c forces the MULT first in a plain pointer-add, which
         * mis-colours the base register otherwise). */
        ep = (u8 *)gEntities_03003720;
        e = (struct Entity *)(ep + id * sizeof(struct Entity));

        if (e->status & 4)
            continue;
        if (gEntities_03003720[0].field_06 != e->field_06)
            continue;
        if (e->collisionType != 3)
            continue;

        left = (u16)((e->y + e->hitHalfH) - e->field_29);
        right = (u16)(e->y + e->hitHalfH);
        top = (e->x + e->hitHalfW) - (e->field_28 >> 1);
        bottom = (u16)((e->x + e->hitHalfW) + (e->field_28 >> 1));

        if (probeY <= top)
            continue;
        if (probeY >= bottom)
            continue;
        if (probeX <= left)
            continue;
        if (probeX < right)
            return 1;
    }

    return 0;
}
