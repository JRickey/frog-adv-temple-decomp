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
extern int SpriteGrid_SetCellFlags(int xTile, int mode, int x, int y, int flags);

void Entity_UpdateHitboxSlots(void *slotsArg, void *outArg, s8 type)
{
    volatile u32 slotsStack;
    volatile u32 outStack;
    volatile s32 typeStack;
    register const EntityHitbox *table asm("r8");
    register const u8 *points asm("r9");
    register u32 r1v asm("r1");
    const EntityHitbox *tbl2;
    u32 typeByte;
    s32 i;
    s32 typeShift;
    register s32 typeIndex asm("r4");
    s32 iShift;
    register s32 slotShift asm("r2");
    u32 pendingMode;
    u32 cleared;
    s32 pointCount;

    slotsStack = (u32)slotsArg;
    outStack = (u32)outArg;
    typeByte = (u8)type;
    i = 0;
    table = sEntityHitboxTable;
    typeShift = typeByte << 24;
    typeIndex = typeShift >> 24;
    pointCount = *(s8 *)((typeIndex * sizeof(EntityHitbox)) + (u32)table);
    if (i >= pointCount)
        goto done;

    tbl2 = table;
    typeStack = typeIndex;
    {
        u32 pointsAddr;

        pointsAddr = 4;
        pointsAddr += (u32)table;
        points = (const u8 *)pointsAddr;
    }
    do {
        CollisionSlot *slot;
        GameStuff *game;
        register u32 slotsBase asm("r7");
        s32 slotOffset;

        slotShift = i << 24;
        slotOffset = slotShift >> 21;
        slotsBase = slotsStack;
        slot = (CollisionSlot *)(slotOffset + slotsBase);
        cleared = 0;
        slot->active = cleared;
        slot->touched = cleared;
        slot->state = cleared;
        slot->flags = cleared;

        game = &gGameStuff;
        iShift = slotShift;
        pendingMode = game->pendingMode;
        if (pendingMode == 1) {
            s32 branchType;
            u32 offset;
            const s16 *pt;
            u32 pointAddr;
            u32 pointBase;
            u32 xTileReg;

            xTileReg = gIwram_35E0._field_18;
            branchType = typeShift >> 24;
            offset = branchType * sizeof(EntityHitbox);
            {
                slotShift = (u32)points;
                asm volatile("" : "+r"(slotShift));
                pointAddr = offset + slotShift;
                pointBase = *(u32 *)pointAddr;
                pointAddr = ((u32)iShift >> 22) + pointBase;
                pt = (const s16 *)pointAddr;
            }
            SpriteGrid_SetCellFlags(xTileReg, 1, pt[0], pt[1], *(u8 *)(offset + (u32)&tbl2->flags));
        } else {
            s32 stackType;
            u32 offset;
            const s16 *pt;
            u32 pointAddr;
            u32 pointsReg;
            u32 pointBase;
            u32 xTileReg;

            xTileReg = gIwram_35E0._field_18;
            stackType = typeStack;
            offset = stackType * sizeof(EntityHitbox);
            pointsReg = (u32)points;
            pointAddr = offset + pointsReg;
            pointBase = *(u32 *)pointAddr;
            pointAddr = ((u32)iShift >> 22) + pointBase;
            pt = (const s16 *)pointAddr;
            SpriteGrid_SetCellFlags(xTileReg, 0, pt[0], pt[1], *(u8 *)(offset + (u32)&tbl2->flags));
        }

        asm volatile("" : "+r"(typeByte));
        {
            u8 *countPtr;

            asm volatile("" : "=r"(r1v) : "0"(typeByte << 24));
            slotShift = iShift + 0x01000000;
            typeShift = r1v;
            r1v = typeShift >> 24;
            countPtr = (u8 *)((r1v * sizeof(EntityHitbox)) + (u32)table);
            i = (u32)slotShift >> 24;
            pointCount = *countPtr;
        }
        pointCount <<= 24;
    } while (slotShift < pointCount);

done: {
    u32 zero0;
    register u32 *out asm("r2");

    zero0 = 0;
    r1v = 0;
    out = (u32 *)outStack;
    out[0] = zero0;
    out[1] = r1v;
}
}
