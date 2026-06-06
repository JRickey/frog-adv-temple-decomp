#include "iwram.h"
#include "types.h"

typedef struct EntityHitbox {
    u32 count;
    u32 points;
    u32 flags;
} EntityHitbox;

typedef struct EntityHitboxFlagBytes {
    u32 count;
    u32 points;
    u8 primaryFlags;
    u8 alternateFlags;
    u8 _padA[2];
} EntityHitboxFlagBytes;

typedef struct EntityHitboxPoint {
    s16 x;
    s16 y;
} EntityHitboxPoint;

extern const EntityHitbox sEntityHitboxTable[];
extern int SpriteGrid_SetCellFlags(int gridId, int gridPlane, int x, int y, int flags);

void EntityHitbox_RegisterGridPoints(u8 type, u32 gridId, u32 gridPlane, u32 useAlternateFlags)
{
    volatile s32 useAlternateFlagsStack;
    volatile u32 typeStack;
    register u32 gridIdReg asm("r9");
    register u32 gridPlaneReg asm("r8");
    register u32 r0v asm("r0");
    register u32 r1v asm("r1");
    const u32 *pointsFieldBase;
    s32 pointIndex;
    s32 pointOffset;
    register s32 savedTypeIndex asm("r5");
    u32 shiftedType;
    const EntityHitbox *hitboxTable;
    u32 initialOffset;
    s32 pointCount;

    typeStack = type;
    gridIdReg = (u8)gridId;
    gridPlaneReg = (u8)gridPlane;
    useAlternateFlagsStack = (u8)useAlternateFlags;
    pointIndex = 0;
    shiftedType = type << 24;
    r1v = (s32)shiftedType >> 24;
    initialOffset = r1v * sizeof(EntityHitbox);
    hitboxTable = sEntityHitboxTable;
    pointCount = *(s8 *)(initialOffset + (u32)hitboxTable);
    if (pointIndex >= pointCount)
        return;

    pointsFieldBase = &hitboxTable->points;
    pointOffset = 0;
    savedTypeIndex = r1v;
    do {
        const EntityHitboxPoint *point;
        s32 branchTypeIndex;
        s32 x;
        register s32 y asm("r3");

        {
            register u32 useAlternateFlagsTest asm("r7");

            useAlternateFlagsTest = useAlternateFlagsStack;
            r0v = 0;
            if (useAlternateFlagsTest == r0v) {
                branchTypeIndex = (s32)shiftedType >> 24;
                r1v = branchTypeIndex * sizeof(EntityHitbox);
                point = (const EntityHitboxPoint *)(pointOffset + *(const u32 *)((u32)r1v + (u32)pointsFieldBase));
                x = point->x;
                y = point->y;
                SpriteGrid_SetCellFlags(
                    gridIdReg, gridPlaneReg, x, y,
                    ((const EntityHitboxFlagBytes *)((u8 *)sEntityHitboxTable + r1v))->primaryFlags);
            } else {
                r1v = savedTypeIndex * sizeof(EntityHitbox);
                point = (const EntityHitboxPoint *)(pointOffset + *(const u32 *)((u32)r1v + (u32)pointsFieldBase));
                x = point->x;
                y = point->y;
                SpriteGrid_SetCellFlags(
                    gridIdReg, gridPlaneReg, x, y,
                    ((const EntityHitboxFlagBytes *)((u8 *)sEntityHitboxTable + r1v))->alternateFlags);
            }
        }
        {
            s32 countTypeIndex;
            u32 countOffset;
            register const s8 *countBase asm("r3");

            r1v = typeStack;
            r0v = r1v << 24;
            asm volatile("" : "+r"(r0v));
            pointOffset += sizeof(EntityHitboxPoint);
            pointIndex++;
            shiftedType = r0v;
            countTypeIndex = (s32)shiftedType >> 24;
            countOffset = countTypeIndex * sizeof(EntityHitbox);
            countBase = (const s8 *)sEntityHitboxTable;
            r1v = countOffset + (u32)countBase;
            pointCount = *(s8 *)r1v;
        }
    } while (pointIndex < pointCount);
}

extern u8 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void CtrlFlags_SetBit(void *base, u32 selector, u32 bit);

void Frog_UpdateContactHitboxes(void)
{
    if (ModeControl_GetFlag(&gIwram_6110, 5, 0) != 0) {
        CtrlFlags_SetBit(&gIwram_6110, 8, 0);
        EntityHitbox_RegisterGridPoints(0, 3, 0, 1);

        if (ModeControl_GetFlag(&gIwram_6110, 5, 1) != 0)
            CtrlFlags_SetBit(&gIwram_6110, 8, 3);
    }

    if (ModeControl_GetFlag(&gIwram_6110, 5, 1) != 0) {
        CtrlFlags_SetBit(&gIwram_6110, 8, 1);
        EntityHitbox_RegisterGridPoints(1, 3, 0, 1);

        if (ModeControl_GetFlag(&gIwram_6110, 5, 0) != 0)
            CtrlFlags_SetBit(&gIwram_6110, 5, 3);
    }

    if (ModeControl_GetFlag(&gIwram_6110, 5, 2) != 0) {
        CtrlFlags_SetBit(&gIwram_6110, 5, 4);
        CtrlFlags_SetBit(&gIwram_6110, 8, 2);
        EntityHitbox_RegisterGridPoints(2, 3, 0, 1);
    }
}
