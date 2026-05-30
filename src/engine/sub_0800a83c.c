#include "types.h"

typedef struct EntityHitbox {
    u32 count;
    u32 points;
    u32 flags;
} EntityHitbox;

typedef struct EntityHitboxFlags {
    u8 _pad0[8];
    u8 flag0;
    u8 flag1;
    u8 _padA[2];
} EntityHitboxFlags;

extern const EntityHitbox sEntityHitboxTable[];
extern int sub_0800CB80(int xTile, int unused, int x, int y, int flags);

void sub_0800A83C(a, b, c, d) u8 a;
u32 b;
u32 c;
u32 d;
{
    volatile s32 dStack;
    volatile u32 aStack;
    register u32 bReg asm("r9");
    register u32 cReg asm("r8");
    register const u32 *pointsBase asm("sl");
    register s32 i asm("r6");
    register s32 j asm("r4");
    register s32 signedA asm("r1");
    register s32 savedA asm("r5");
    register u32 shiftedA asm("r2");
    register const EntityHitbox *tableBase asm("r3");
    register u32 initialOffset asm("r0");
    register s32 loopCount asm("r0");

    aStack = a;
    asm volatile("" : "=r"(b), "=r"(c) : "m"(aStack), "0"(b), "1"(c));
    bReg = (u8)b;
    cReg = (u8)c;
    dStack = (u8)d;
    i = 0;
    shiftedA = a << 24;
    signedA = (s32)shiftedA >> 24;
    initialOffset = (signedA * 3) << 2;
    tableBase = sEntityHitboxTable;
    loopCount = *(s8 *)(initialOffset + (u32)tableBase);
    if (i >= loopCount)
        return;

    tableBase = (const EntityHitbox *)((u8 *)tableBase + 4);
    pointsBase = (const u32 *)tableBase;
    j = 0;
    savedA = signedA;
    do {
        const s16 *pt;
        register s32 branchA asm("r0");
        register u32 offset asm("r1");
        register s32 x asm("r2");
        register s32 y asm("r3");

        asm volatile("" : "+r"(loopCount));
        {
            register u32 dTest asm("r7");
            register u32 zero asm("r0");

            dTest = dStack;
            zero = 0;
            if (dTest != zero)
                goto nonzero_d;
        }
        {
            branchA = (s32)shiftedA >> 24;
            offset = (branchA * 3) << 2;
            pt = (const s16 *)((u8 *)((u32)j + *(const u32 *)((u32)offset + (u32)pointsBase)));
            x = pt[0];
            y = pt[1];
            sub_0800CB80(bReg, cReg, x, y, ((const EntityHitboxFlags *)((u8 *)sEntityHitboxTable + offset))->flag0);
            goto after_call;
        }

    nonzero_d: {
        offset = (savedA * 3) << 2;
        pt = (const s16 *)((u8 *)((u32)j + *(const u32 *)((u32)offset + (u32)pointsBase)));
        x = pt[0];
        y = pt[1];
        sub_0800CB80(bReg, cReg, x, y, ((const EntityHitboxFlags *)((u8 *)sEntityHitboxTable + offset))->flag1);
    }

    after_call: {
        register u32 aLoad asm("r1");
        register u32 aShift asm("r0");
        register s32 countA asm("r0");
        register u32 countOffset asm("r1");
        register const s8 *countBase asm("r3");
        register s8 *countPtr asm("r1");

        aLoad = aStack;
        aShift = aLoad << 24;
        asm volatile("" : "+r"(aShift));
        j += 4;
        i++;
        shiftedA = aShift;
        countA = (s32)shiftedA >> 24;
        countOffset = (countA * 3) << 2;
        countBase = (const s8 *)sEntityHitboxTable;
        countPtr = (s8 *)(countOffset + (u32)countBase);
        loopCount = *countPtr;
    }
    } while (i < loopCount);
}
