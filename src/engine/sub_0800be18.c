#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

typedef struct CollisionSlot {
    u32 flags;
    u8 active;
    u8 touched;
    u8 state;
    u8 _pad7;
} CollisionSlot;

extern const EntityHitbox sEntityHitboxTable[];
extern int SpriteGrid_SetCellFlags(int xTile, int unused, int x, int y, int flags);

/* Resets the first N collision slots of the per-entity array at `slots`
 * (8-byte records) and re-registers each as a collision point.
 *
 * N is the point count of sEntityHitboxTable[type] (the signed low byte
 * at +0). For each slot i: clears the u32 at +0 and the three bytes at
 * +4..+6, reads the (x, y) pair from sEntityHitboxTable[type].points[i],
 * loads the table entry's flag byte (+8), and calls
 *   SpriteGrid_SetCellFlags(gIwram_35E0._field_18, 0, x, y, flags)
 * to register the point. `out` (arg1) is finally zeroed (two u32 writes).
 *
 * Matching note: old_agbcc must keep `type << 24` live in r9 across the
 * SpriteGrid_SetCellFlags call. The empty barrier prevents copy-prop from replacing it
 * with the sign-extended type index before the loop body.
 */

void sub_0800BE18(CollisionSlot *slotsArg, unsigned long long *outArg, s8 type)
{
    volatile unsigned long long *outAddr;
    CollisionSlot *slots;
    register u32 shiftedType asm("r9");
    const EntityHitbox *tableBase;
    const EntityHitbox *table;
    s32 indexByte;
    s32 pointIndex;
    register s32 typeIndex asm("r6");
    u32 cleared;
    s32 pointCount;

    slots = slotsArg;
    outAddr = outArg;
    indexByte = 0;
    table = sEntityHitboxTable;
    shiftedType = type << 24;
    {
        register s32 typeIndex asm("r0");
        u32 offset;

        typeIndex = (s32)shiftedType >> 24;
        offset = typeIndex * sizeof(EntityHitbox);
        pointCount = *(s8 *)(offset + (u32)table);
    }
    if (indexByte >= pointCount)
        goto done;

    cleared = 0;
    tableBase = table;
    do {
        CollisionSlot *slot;
        const s16 *pt;
        u32 offset;
        register u32 pointsBase asm("r1");
        u32 pointAddr;
        u32 xTile;
        s32 x;
        s32 y;
        u32 flag;

        indexByte <<= 24;
        pointIndex = indexByte >> 24;
        slot = &slots[pointIndex];
        slot->active = cleared;
        slot->touched = cleared;
        slot->state = cleared;
        slot->flags = cleared;

        asm volatile("" : "+r"(shiftedType));
        typeIndex = (s32)shiftedType >> 24;
        xTile = gIwram_35E0._field_18;
        offset = typeIndex * sizeof(EntityHitbox);
        pointsBase = (u32)&tableBase->points;
        pointsBase = offset + pointsBase;
        pointsBase = *(u32 *)pointsBase;
        pointAddr = ((u32)indexByte >> 22) + pointsBase;
        pt = (const s16 *)pointAddr;
        x = pt[0];
        y = pt[1];
        flag = *(u8 *)((u32)&tableBase->flags + offset);
        SpriteGrid_SetCellFlags(xTile, 0, x, y, flag);

        pointIndex++;
        pointIndex <<= 24;
        {
            u32 countAddr;

            countAddr = typeIndex * sizeof(EntityHitbox);
            countAddr = (u32)tableBase + countAddr;
            indexByte = (u32)pointIndex >> 24;
            pointCount = *(u8 *)countAddr;
            pointCount <<= 24;
        }
    } while (pointIndex < pointCount);

done:
    *outAddr = 0;
}

/* Twin of Entity_ActivateHitSlot (item-pickup handler) without the SFX call: on
 * b == 23, looks up an entity slot via EntityHitbox_FindPoint(a, gIwram_35E0.tileX,
 * gIwram_35E0.tileY) and, if the slot's flag byte at +4 is clear, claims
 * it (clear +5, set +4, copy gGameStuff._unk00 to +0) and OR's (1 << idx)
 * into the caller-supplied 64-bit mask. */

extern s8 EntityHitbox_FindPoint(s8 a, s16 x, s16 y);

struct EntryB8A8 {
    u32 _field_0;
    u8 _field_4;
    u8 _field_5;
    u8 _pad6[2];
};

void sub_0800BEBC(struct EntryB8A8 *arr, unsigned long long *mask, u8 a, u8 b)
{
    s8 idx;
    struct EntryB8A8 *entry;

    if (b != 23)
        return;

    idx = EntityHitbox_FindPoint((s8)a, gIwram_35E0._field_8, gIwram_35E0._field_A);
    if (idx == -1)
        return;

    entry = (struct EntryB8A8 *)((u32)(idx << 3) + (u32)arr);
    if (entry->_field_4 != 0)
        return;

    entry->_field_5 = 0;
    entry->_field_4 = 1;
    entry->_field_0 = gGameStuff._unk00;
    *mask |= (unsigned long long)1 << idx;
}
