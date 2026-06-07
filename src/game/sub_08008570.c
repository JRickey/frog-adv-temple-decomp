#include "entity.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Entity_UpdateJumpTarget — directional-move resolver for the player.
 *
 * Reads the pending move opcode (record 0 / gIwram_3720 +0x1A, opcodes 4..11),
 * builds a destination box via Entity_GetDirHitbox, scans the active 56-byte entity
 * records at 0x03003720 for a blocker (kind 2) inside the box, latches its id
 * into gIwram_35E0+0x1A, then commits the tile delta into gIwram_35E0+0x1C/+0x1E
 * per the cardinal direction and hop length encoded in the opcode. */

extern struct Entity gEntities_03003720[];
extern struct IndexEntry gEntityIndex_03006160[];

void Entity_GetDirHitbox(u8 dir, u8 a, u8 b, u8 c, s16 *xLo, s16 *xHi, s16 *yLo, s16 *yHi);

u8 Entity_UpdateJumpTarget(void)
{
    s16 xLo, xHi, yLo, yHi;
    s32 i;

    if (gEntities[0].status & 4)
        return 0;

    switch (gEntities[0].state) {
    case 4:
        Entity_GetDirHitbox(0, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 5:
        Entity_GetDirHitbox(1, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 6:
        Entity_GetDirHitbox(2, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 7:
        Entity_GetDirHitbox(3, 24, 24, 24, &xLo, &xHi, &yLo, &yHi);
        break;
    case 8:
        Entity_GetDirHitbox(0, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    case 9:
        Entity_GetDirHitbox(1, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    case 10:
        Entity_GetDirHitbox(2, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    case 11:
        Entity_GetDirHitbox(3, 48, 20, 20, &xLo, &xHi, &yLo, &yHi);
        break;
    }

    if (gEntities_03003720[0].state <= 7) {
        for (i = 0; i < gIwram_6110.liveCount; i++) {
            u8 id = gEntityIndex_03006160[i].id;
            struct Entity *e;
            u8 *ep;

            if (id == 0)
                continue;

            ep = (u8 *)gEntities_03003720;
            e = (struct Entity *)(ep + id * sizeof(struct Entity));

            if (e->status & 4)
                continue;
            if (gEntities_03003720[0].field_06 != e->field_06)
                continue;
            if (e->x <= yLo)
                continue;
            if (e->x >= yHi)
                continue;
            if (e->y <= xLo)
                continue;
            if (e->y >= xHi)
                continue;
            if (e->field_01 != 2)
                continue;

            gIwram_35E0._field_1A = id;
            goto commit;
        }
    }

    gIwram_35E0._field_1A = 0;

commit:
    switch (gEntities_03003720[0].state) {
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
