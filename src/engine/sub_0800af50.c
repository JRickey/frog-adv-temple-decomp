#include "entity.h"
#include "iwram.h"
#include "types.h"
#include "game.h"

typedef struct EntityHitboxFlagBytes {
    u32 count;
    u32 points;
    u8 primaryFlags;
    u8 _padA[3];
} EntityHitboxFlagBytes;

typedef struct EntityHitboxPoint {
    s16 x;
    s16 y;
} EntityHitboxPoint;

typedef struct EntitySlot {
    u32 field0;
    u8 field4;
    u8 field5;
    u8 field6;
    u8 _pad7;
} EntitySlot;

extern const EntityHitbox sEntityHitboxTable[];
extern int SpriteGrid_SetCellFlags(int xTile, int mode, int x, int y, int flags);

void Entity_InitHitboxSlots(EntitySlot *slots)
{
    u32 slotsStack;
    register u32 r0v asm("r0");
    register s32 type asm("r5"); /* held across the inner bl; agbcc won't pick r5 unpinned */
    register s32 i asm("r9");    /* outer/clear loop counter, callee-saved across the bl */
    s32 j;
    s32 typeShift;
    s32 savedTypeShift;
    s32 pointCount;

    slotsStack = (u32)slots;
    type = 24;
    i = 0;
    do {
        EntitySlot *slot;
        s32 typeIndex;
        const EntityHitbox *table;
        const EntityHitbox *base;
        u32 initOffset;

        slot = (EntitySlot *)((u32)(((s32)(i << 16)) >> 13) + slotsStack);
        slot->field4 = 0;
        slot->field5 = 0;
        slot->field6 = 0;
        slot->field0 = 0;

        j = 0;
        typeShift = type << 24;
        typeIndex = typeShift >> 24;
        initOffset = typeIndex * sizeof(EntityHitbox);
        /* One `base` feeds both the count read and `table`, so the pool load
         * for sEntityHitboxTable materializes inside the loop (CSE would hoist
         * a second reference out and merge them into one pre-loop load). */
        base = sEntityHitboxTable;
        pointCount = *(s8 *)(initOffset + (u32)base);
        savedTypeShift = typeShift;
        if (j >= pointCount)
            goto next;

        table = base;

        do {
            const EntityHitboxPoint *pt;
            u32 offset;
            s32 xTile;
            s32 jShift;
            u32 pointsBase;

            /* Barrier forces `asrs r5,r6,#24` (direct) for the type recompute
             * instead of an in-place shift + copy. */
            asm volatile("" : "+r"(typeShift));
            type = typeShift >> 24;
            xTile = gIwram_35E0._field_18;
            jShift = j << 24;
            offset = type * sizeof(EntityHitbox);

            pointsBase = (u32)table + 4;
            pointsBase = *(const u32 *)(offset + pointsBase);
            pt = (const EntityHitboxPoint *)(((u32)jShift >> 22) + pointsBase);

            SpriteGrid_SetCellFlags(xTile, 0, pt->x, pt->y,
                                    ((const EntityHitboxFlagBytes *)(offset + (u32)table))->primaryFlags);

            j = (u32)((j << 16) + 0x10000) >> 16;
        } while ((s16)j < *(s8 *)((type * sizeof(EntityHitbox)) + (u32)table));

    next: {
        s32 iWrap;

        iWrap = (i << 16) + 0x10000;
        r0v = savedTypeShift + 0x01000000;
        type = r0v >> 24;
        i = (u32)iWrap >> 16;
    }
    } while ((s16)i <= 3);

    i = 0;
    {
        u8 *base = (u8 *)0x03003610;

        do {
            s16 idx;

            idx = (s16)i;
            *(u8 *)(idx + (u32)base) = 1;
            i = (u16)(idx + 1);
        } while ((s16)i <= 254);
    }

    i = 0;
    {
        u32 base = 0x03003610;

        do {
            s32 idx;
            s32 stride;

            idx = (s16)i;
            r0v = idx;
            r0v += 42;
            *(u8 *)(r0v + base) = 0;
            r0v = idx;
            r0v += 154;
            *(u8 *)(r0v + base) = 0;
            stride = ((idx << 3) - idx) << 1;
            r0v = stride + 1;
            *(u8 *)(r0v + base) = 0;
            stride += 12;
            *(u8 *)(stride + base) = 0;
            i = (u16)(idx + 1);
        } while ((s16)i <= 13);
    }
}

extern u8 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(u8 *base, u32 selector, u32 bit);
extern void Sound_Play(u32 sound);

void Gate_PollResult(EntitySlot *slots)
{
    s32 result;
    u8 *base3720;
    s32 counter;

    /* 0xff is the "no slot" sentinel; read back as (s8) it is -1. Initialising
     * to 0xff (not -1) emits `movs #255` and keeps the (s8) narrowing live. */
    result = 0xff;

    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 5, 8)) {
        base3720 = (u8 *)gEntities;
        result = (*(s16 *)(base3720 + 0xb70) != 0);
        ModeControl_ClearBit((u8 *)&gIwram_6110, 5, 8);
    }

    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 5, 9)) {
        base3720 = (u8 *)gEntities;
        counter = *(s16 *)(base3720 + 0xb70);
        result = 1;
        if (counter != 0)
            result = 2;
        ModeControl_ClearBit((u8 *)&gIwram_6110, 5, 9);
    }

    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 5, 10)) {
        base3720 = (u8 *)gEntities;
        counter = *(s16 *)(base3720 + 0xb70);
        result = 2;
        if (counter != 0)
            result = 3;
        ModeControl_ClearBit((u8 *)&gIwram_6110, 5, 10);
    }

    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 5, 11)) {
        base3720 = (u8 *)gEntities;
        counter = *(s16 *)(base3720 + 0xb70);
        result = 3;
        if (counter != 0)
            result = 0;
        ModeControl_ClearBit((u8 *)&gIwram_6110, 5, 11);
    }

    {
        s32 type = (s8)result;
        EntitySlot *slot;

        if (type == -1)
            return;

        /* index-first add so the `type * 8` lands as the lead `adds` operand. */
        slot = (EntitySlot *)((type << 3) + (u32)slots);

        if (slot->field4 != 0)
            return;

        slot->field5 = 0;
        slot->field4 = 1;
        slot->field0 = gGameStuff._unk00;
        Sound_Play(0x6c);
    }
}
