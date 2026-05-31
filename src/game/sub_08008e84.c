#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08008E84 — directional hit-test: probe a point 24px off the player
 * header in one of four cardinal directions against the active 56-byte entity
 * records, returning 1 if any record's axis-aligned box contains it.
 *
 * The probe point is built from the player header (record 0 at 0x03003720,
 * fields +2/+4) per the direction argument:
 *   1: ( header+2,        header+4 - 24 )
 *   2: ( header+2,        header+4 + 24 )
 *   4: ( header+2 - 24,   header+4      )
 *   8: ( header+2 + 24,   header+4      )
 * then matched against the same box test as sub_08008F98 (record+1 must be 3
 * here, not 2), walking the active-entity index table at 0x03006160. */

struct Entity {
    u8 _pad00;
    u8 _b1;  /* +1: kind; the probe only hits records with kind 3 */
    s16 _h2; /* +2 */
    s16 _h4; /* +4 */
    u8 _b6;  /* +6: must match the player header byte */
    u8 _pad07[0x1D];
    s16 _h24; /* +0x24 */
    s16 _h26; /* +0x26 */
    u8 _b28;  /* +0x28 */
    u8 _b29;  /* +0x29 */
    u8 _pad2A[0xA];
    u16 _h34; /* +0x34: bit 0x04 = inactive */
    u8 _pad36[2];
};

struct IndexEntry {
    u8 id;
    u8 _pad[7];
};

extern struct Entity gEntities_03003720[];
extern struct IndexEntry gEntityIndex_03006160[];

u8 sub_08008E84(u8 dir)
{
    s16 probeY;
    s16 probeX;
    s32 i;

    switch (dir) {
    case 1:
        probeY = gEntities_03003720[0]._h2;
        probeX = gEntities_03003720[0]._h4 - 24;
        break;
    case 2:
        probeY = gEntities_03003720[0]._h2;
        probeX = gEntities_03003720[0]._h4 + 24;
        break;
    case 4:
        probeY = gEntities_03003720[0]._h2 - 24;
        probeX = gEntities_03003720[0]._h4;
        break;
    case 8:
        probeY = gEntities_03003720[0]._h2 + 24;
        probeX = gEntities_03003720[0]._h4;
        break;
    }

    for (i = 0; i < gIwram_6110._pad30[1]; i++) {
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

        if (e->_h34 & 4)
            continue;
        if (gEntities_03003720[0]._b6 != e->_b6)
            continue;
        if (e->_b1 != 3)
            continue;

        left = (u16)((e->_h4 + e->_h26) - e->_b29);
        right = (u16)(e->_h4 + e->_h26);
        top = (e->_h2 + e->_h24) - (e->_b28 >> 1);
        bottom = (u16)((e->_h2 + e->_h24) + (e->_b28 >> 1));

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
