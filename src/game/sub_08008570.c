#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08008570 — directional-move resolver for the player.
 *
 * Reads the pending move opcode (record 0 / gIwram_3720 +0x1A, opcodes 4..11),
 * builds a destination box via sub_080089A4, scans the active 56-byte entity
 * records at 0x03003720 for a blocker (kind 2) inside the box, latches its id
 * into gIwram_35E0+0x1A, then commits the tile delta into gIwram_35E0+0x1C/+0x1E
 * per the cardinal direction and hop length encoded in the opcode. */

struct Entity {
    u8 _pad00;
    u8 _b1;  /* +1: kind; a blocker is kind 2 */
    s16 _h2; /* +2 */
    s16 _h4; /* +4 */
    u8 _b6;  /* +6: must match the player header byte */
    u8 _pad07[0x13];
    u8 _opcode; /* +0x1A: record 0 holds the pending move opcode */
    u8 _pad1B[0x19];
    u16 _h34; /* +0x34: bit 0x04 = inactive */
    u8 _pad36[2];
};

struct IndexEntry {
    u8 id;
    u8 _pad[7];
};

extern struct Entity gEntities_03003720[];
extern struct IndexEntry gEntityIndex_03006160[];

void sub_080089A4(u8 dir, u8 a, u8 b, u8 c, s16 *xLo, s16 *xHi, s16 *yLo, s16 *yHi);

u8 sub_08008570(void)
{
    s16 xLo, xHi, yLo, yHi;
    s32 i;

    if (gIwram_3720._field_34 & 4)
        return 0;

    switch (gIwram_3720._field_1A) {
    case 4:
        sub_080089A4(0, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 5:
        sub_080089A4(1, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 6:
        sub_080089A4(2, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 7:
        sub_080089A4(3, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 8:
        sub_080089A4(0, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    case 9:
        sub_080089A4(1, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    case 10:
        sub_080089A4(2, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    case 11:
        sub_080089A4(3, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    }

    if (gEntities_03003720[0]._opcode <= 7) {
        for (i = 0; i < gIwram_6110.liveCount; i++) {
            u8 id = gEntityIndex_03006160[i].id;
            struct Entity *e;
            u8 *ep;

            if (id == 0)
                continue;

            ep = (u8 *)gEntities_03003720;
            e = (struct Entity *)(ep + id * sizeof(struct Entity));

            if (e->_h34 & 4)
                continue;
            if (gEntities_03003720[0]._b6 != e->_b6)
                continue;
            if (e->_h2 <= yLo)
                continue;
            if (e->_h2 >= yHi)
                continue;
            if (e->_h4 <= xLo)
                continue;
            if (e->_h4 >= xHi)
                continue;
            if (e->_b1 != 2)
                continue;

            gIwram_35E0._field_1A = id;
            goto commit;
        }
    }

    gIwram_35E0._field_1A = 0;

commit:
    switch (gEntities_03003720[0]._opcode) {
    case 4:
        gIwram_35E0._field_1C = gIwram_35E0._field_8;
        gIwram_35E0._field_1E = gIwram_35E0._field_A - 1;
        break;
    case 5:
        gIwram_35E0._field_1C = gIwram_35E0._field_8;
        gIwram_35E0._field_1E = gIwram_35E0._field_A + 1;
        break;
    case 6:
        gIwram_35E0._field_1C = gIwram_35E0._field_8 - 1;
        gIwram_35E0._field_1E = gIwram_35E0._field_A;
        break;
    case 7:
        gIwram_35E0._field_1C = gIwram_35E0._field_8 + 1;
        gIwram_35E0._field_1E = gIwram_35E0._field_A;
        break;
    case 8:
        gIwram_35E0._field_1C = gIwram_35E0._field_8;
        gIwram_35E0._field_1E = gIwram_35E0._field_A - 2;
        break;
    case 9:
        gIwram_35E0._field_1C = gIwram_35E0._field_8;
        gIwram_35E0._field_1E = gIwram_35E0._field_A + 2;
        break;
    case 10:
        gIwram_35E0._field_1C = gIwram_35E0._field_8 - 2;
        gIwram_35E0._field_1E = gIwram_35E0._field_A;
        break;
    case 11:
        gIwram_35E0._field_1C = gIwram_35E0._field_8 + 2;
        gIwram_35E0._field_1E = gIwram_35E0._field_A;
        break;
    }

    return 0;
}
