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
extern int sub_0800CB80(int gridId, int gridPlane, int x, int y, int flags);

void sub_0800A83C(u8 type, u32 gridId, u32 gridPlane, u32 useAlternateFlags)
{
    volatile s32 useAlternateFlagsStack;
    volatile u32 typeStack;
    register u32 gridIdReg asm("r9");
    register u32 gridPlaneReg asm("r8");
    const u32 *pointsFieldBase;
    s32 pointIndex;
    s32 pointOffset;
    register s32 typeIndex asm("r1");
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
    typeIndex = (s32)shiftedType >> 24;
    initialOffset = typeIndex * sizeof(EntityHitbox);
    hitboxTable = sEntityHitboxTable;
    pointCount = *(s8 *)(initialOffset + (u32)hitboxTable);
    if (pointIndex >= pointCount)
        return;

    pointsFieldBase = &hitboxTable->points;
    pointOffset = 0;
    savedTypeIndex = typeIndex;
    do {
        const EntityHitboxPoint *point;
        s32 branchTypeIndex;
        register u32 offset asm("r1");
        register s32 x asm("r2");
        register s32 y asm("r3");

        {
            register u32 useAlternateFlagsTest asm("r7");
            register u32 zero asm("r0");

            useAlternateFlagsTest = useAlternateFlagsStack;
            zero = 0;
            if (useAlternateFlagsTest == zero) {
                branchTypeIndex = (s32)shiftedType >> 24;
                offset = branchTypeIndex * sizeof(EntityHitbox);
                point = (const EntityHitboxPoint *)(pointOffset + *(const u32 *)((u32)offset + (u32)pointsFieldBase));
                x = point->x;
                y = point->y;
                sub_0800CB80(gridIdReg, gridPlaneReg, x, y,
                             ((const EntityHitboxFlagBytes *)((u8 *)sEntityHitboxTable + offset))->primaryFlags);
            } else {
                offset = savedTypeIndex * sizeof(EntityHitbox);
                point = (const EntityHitboxPoint *)(pointOffset + *(const u32 *)((u32)offset + (u32)pointsFieldBase));
                x = point->x;
                y = point->y;
                sub_0800CB80(gridIdReg, gridPlaneReg, x, y,
                             ((const EntityHitboxFlagBytes *)((u8 *)sEntityHitboxTable + offset))->alternateFlags);
            }
        }
        {
            register u32 typeLoad asm("r1");
            register u32 typeShift asm("r0");
            s32 countTypeIndex;
            u32 countOffset;
            register const s8 *countBase asm("r3");
            register s8 *countPtr asm("r1");

            typeLoad = typeStack;
            typeShift = typeLoad << 24;
            asm volatile("" : "+r"(typeShift));
            pointOffset += sizeof(EntityHitboxPoint);
            pointIndex++;
            shiftedType = typeShift;
            countTypeIndex = (s32)shiftedType >> 24;
            countOffset = countTypeIndex * sizeof(EntityHitbox);
            countBase = (const s8 *)sEntityHitboxTable;
            countPtr = (s8 *)(countOffset + (u32)countBase);
            pointCount = *countPtr;
        }
    } while (pointIndex < pointCount);
}

extern u8 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_08006600(void *base, u32 selector, u32 bit);

void sub_0800A910(void)
{
    if (sub_0800679C(&gIwram_6110, 5, 0) != 0) {
        sub_08006600(&gIwram_6110, 8, 0);
        sub_0800A83C(0, 3, 0, 1);

        if (sub_0800679C(&gIwram_6110, 5, 1) != 0)
            sub_08006600(&gIwram_6110, 8, 3);
    }

    if (sub_0800679C(&gIwram_6110, 5, 1) != 0) {
        sub_08006600(&gIwram_6110, 8, 1);
        sub_0800A83C(1, 3, 0, 1);

        if (sub_0800679C(&gIwram_6110, 5, 0) != 0)
            sub_08006600(&gIwram_6110, 5, 3);
    }

    if (sub_0800679C(&gIwram_6110, 5, 2) != 0) {
        sub_08006600(&gIwram_6110, 5, 4);
        sub_08006600(&gIwram_6110, 8, 2);
        sub_0800A83C(2, 3, 0, 1);
    }
}
