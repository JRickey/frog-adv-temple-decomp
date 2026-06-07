#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Entity_CheckAllCollisions — per-frame entity "pose reaction" pass.
 *
 * Walks the active-entity index at 0x03006160 and, for every live record whose
 * box overlaps the player header (record 0), dispatches on the record's pose
 * byte (collisionType, opcodes 1..11) to either: latch the record into the shared
 * input scratch at gIwram_35E0 (+0xC id, +0xD kind), raise a hop/move flag bit
 * on gIwram_35E0 via PlayerFlags_Set, or just mark the record "seen" (status bit
 * 0x80). Each record's status bit 0x80 is cleared at the top of every iteration
 * before the dispatch decides whether to re-raise it. */

extern struct Entity gEntities_03003720[];
extern struct IndexEntry gEntityIndex_03006160[];

extern void Entity_DispatchSound(struct Entity *e);
extern u8 Entity_BBoxOverlap(struct Entity *p1, struct Entity *p2);
extern u8 Entity_RectOverlap(struct Entity *p1, struct Entity *p2);

void Entity_CheckAllCollisions(void)
{
    s32 i;

    if (gEntities[0].status & 4)
        return;

    gIwram_35E0.collisionType = 0;
    gIwram_35E0.colliderTag = 0;
    if ((gIwram_35E0._field_10 & 2) == 0)
        gIwram_35E0.platformId = 0;

    for (i = 0; i < gIwram_6110.liveCount; i++) {
        u8 id = gEntityIndex_03006160[i].id;
        struct Entity *e;
        u8 *ep;
        u16 st;

        /* Materialise the record-array base into ep before the id*0x38 offset so
         * agbcc emits the base load ahead of the index multiply. */
        ep = (u8 *)gEntities_03003720;
        e = (struct Entity *)(ep + id * sizeof(struct Entity));

        /* Cache the masked status and reuse it for the bit-4 test (one ldrh, not
         * two) — the reuse is also what gives `id` the lower register. */
        st = e->status & 0xFF7F;
        e->status = st;

        if (id == 0)
            continue;
        if (st & 4)
            continue;
        if (gEntities_03003720[0].actorId != e->actorId)
            continue;

        Entity_DispatchSound(e);
        if (!Entity_BBoxOverlap(&gEntities_03003720[0], e))
            continue;

        switch (e->collisionType - 1) {
        case 0:
            if (gEntities_03003720[0].state > 3 && (gIwram_35E0._field_10 & 0x10) == 0)
                continue;
            gIwram_35E0.collisionType |= gEntities_03003720[id].collisionType;
            gEntities_03003720[id].status |= 0x80;
            break;

        case 1:
            if (!Entity_RectOverlap(&gEntities_03003720[0], &gEntities_03003720[id]))
                continue;
            gIwram_35E0.collisionType |= gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = id;
            if (gEntities_03003720[0].state > 3 && (gIwram_35E0._field_10 & 0x10) == 0)
                continue;
            gEntities_03003720[id].status |= 0x80;
            gIwram_35E0._field_10 |= 2;
            gIwram_35E0.platformId = id;
            break;

        case 4:
            if (gGameStuff._unk10 & 1)
                continue;
            gIwram_35E0.collisionType = gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = gEntities_03003720[id].kind;
            PlayerFlags_Set(&gIwram_35E0, 0x200);
            return;

        case 6:
            if (gGameStuff._unk10 & 1)
                continue;
            if ((u8)(gEntities_03003720[0].state - 8) <= 3)
                continue;
            gIwram_35E0.collisionType = gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = gEntities_03003720[id].kind;
            PlayerFlags_Set(&gIwram_35E0, 0x400);
            return;

        case 3:
        case 7:
            if (gGameStuff._unk10 & 1)
                continue;
            gIwram_35E0.collisionType = gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = gEntities_03003720[id].kind;
            PlayerFlags_Set(&gIwram_35E0, 0x400);
            return;

        case 5:
            if (gGameStuff._unk10 & 1)
                continue;
            gIwram_35E0.collisionType = gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = gEntities_03003720[id].kind;
            PlayerFlags_Set(&gIwram_35E0, 0x800);
            return;

        case 8:
            if (gGameStuff._unk10 & 1)
                continue;
            gIwram_35E0.collisionType = gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = gEntities_03003720[id].kind;
            PlayerFlags_Set(&gIwram_35E0, 0x4000);
            return;

        case 9:
            if (gGameStuff._unk10 & 1)
                continue;
            gIwram_35E0.collisionType = gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = gEntities_03003720[id].kind;
            PlayerFlags_Set(&gIwram_35E0, 0x8000);
            return;

        case 10:
            if (gGameStuff._unk10 & 1)
                continue;
            if ((u8)(gEntities_03003720[0].state - 8) <= 3)
                continue;
            gIwram_35E0.collisionType = gEntities_03003720[id].collisionType;
            gIwram_35E0.colliderTag = gEntities_03003720[id].kind;
            PlayerFlags_Set(&gIwram_35E0, 0x8000);
            return;

        case 2:
        default:
            gEntities_03003720[id].status |= 0x80;
            break;
        }
    }
}
