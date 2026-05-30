#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

typedef struct EntityHitbox {
    u32 count;
    u32 points;
    u32 flags;
} EntityHitbox;

extern const EntityHitbox sEntityHitboxTable[];
extern int sub_0800CB80(int xTile, int unused, int x, int y, int flags);

/* Resets the first N collision slots of the per-entity array at `slots`
 * (8-byte records) and re-registers each as a collision point.
 *
 * N is the point count of sEntityHitboxTable[type] (the signed low byte
 * at +0). For each slot i: clears the u32 at +0 and the three bytes at
 * +4..+6, reads the (x, y) pair from sEntityHitboxTable[type].points[i],
 * loads the table entry's flag byte (+8), and calls
 *   sub_0800CB80(gIwram_35E0._field_18, 0, x, y, flags)
 * to register the point. `out` (arg1) is finally zeroed (two u32 writes).
 *
 * Matched C relies on explicit high-register pins for the slot base, shifted
 * type, and hitbox-table base across the inner sub_0800CB80 call.
 */

void sub_0800BE18(slotsArg, outArg, type) u8 *slotsArg;
u32 *outArg;
u32 type;
{
    volatile u32 outStack;
    register u8 *slots asm("sl");
    register u32 typeShift asm("r9");
    register const EntityHitbox *tableBase asm("r8");
    register const EntityHitbox *table asm("r4");
    register s32 i asm("r3");
    register s32 iSigned asm("r5");
    register s32 typeSigned asm("r6");
    register u32 zero;
    register s32 count asm("r0");

    slots = slotsArg;
    outStack = (u32)outArg;
    i = 0;
    table = sEntityHitboxTable;
    typeShift = type << 24;
    {
        register s32 typeSigned asm("r0");
        register u32 offset asm("r1");
        register s8 *countPtr asm("r1");
        register s32 zeroIndex asm("r0");

        typeSigned = (s32)typeShift >> 24;
        offset = (typeSigned * 3) << 2;
        countPtr = (s8 *)(offset + (u32)table);
        zeroIndex = 0;
        count = countPtr[zeroIndex];
    }
    if (i >= count)
        goto done;

    zero = 0;
    tableBase = table;
    do {
        u8 *slot;
        const s16 *pt;
        register u32 offset asm("r4");
        register u32 pointsBase asm("r1");
        register u32 pointAddr asm("r3");
        register u32 xTile asm("r0");
        register s32 x asm("r2");
        register s32 y asm("r3");
        register u32 flag asm("r1");

        i <<= 24;
        iSigned = i >> 24;
        slot = (u8 *)((iSigned << 3) + (u32)slots);
        slot[4] = zero;
        slot[5] = zero;
        slot[6] = zero;
        *(u32 *)slot = zero;

        asm volatile("" : "+r"(typeShift));
        typeSigned = (s32)typeShift >> 24;
        xTile = gIwram_35E0._field_18;
        offset = (typeSigned * 3) << 2;
        pointsBase = (u32)tableBase + 4;
        pointsBase = offset + pointsBase;
        pointsBase = *(u32 *)pointsBase;
        pointAddr = ((u32)i >> 22) + pointsBase;
        pt = (const s16 *)pointAddr;
        x = pt[0];
        y = pt[1];
        flag = *(u8 *)((u32)tableBase + offset + 8);
        sub_0800CB80(xTile, 0, x, y, flag);

        iSigned++;
        iSigned <<= 24;
        {
            register u32 countOffset asm("r0");

            countOffset = (typeSigned * 3) << 2;
            countOffset = (u32)tableBase + countOffset;
            i = (u32)iSigned >> 24;
            count = *(u8 *)countOffset;
            count <<= 24;
        }
    } while (iSigned < count);

done: {
    register u32 zero0 asm("r0");
    register u32 zero1 asm("r1");
    register u32 *outPtr asm("r2");

    zero0 = 0;
    zero1 = 0;
    outPtr = (u32 *)outStack;
    outPtr[0] = zero0;
    outPtr[1] = zero1;
}
}

/* Twin of sub_0800B8A8 (item-pickup handler) without the SFX call: on
 * b == 23, looks up an entity slot via sub_0800A7A8(a, gIwram_35E0.tileX,
 * gIwram_35E0.tileY) and, if the slot's flag byte at +4 is clear, claims
 * it (clear +5, set +4, copy gGameStuff._unk00 to +0) and OR's (1 << idx)
 * into the caller-supplied 64-bit mask. */

extern s8 sub_0800A7A8(s8 a, s16 x, s16 y);

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

    idx = sub_0800A7A8((s8)a, gIwram_35E0._field_8, gIwram_35E0._field_A);
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
