#include "iwram.h"
#include "macros.h"
#include "types.h"

extern int __divsi3(int num, int den);

void sub_080087B4(void)
{
    u8 *gA0 = (u8 *)gEntities;
    s32 hi = gA0[0x1c];
    s32 lo = gA0[0x1b];
    u8 *gB0 = (u8 *)&gIwram_35E0;
    u8 selector = *(vu8 *)(gB0 + 0x1a);
    u8 *gA = gA0;
    u8 *gB = gB0;
    register u8 *gB2 asm("r2");
    register u8 *e asm("r1");
    register s32 num asm("r0");
    register s32 ref asm("r1");

    if (selector != 0) {
        e = gA + gB[0x1a] * 0x38;
        num = *(s16 *)(e + 4);
        num += *(s16 *)(e + 0x26);
        num -= e[0x29] >> 1;
        ref = *(s16 *)(gA + 4);
    } else {
        asm("" ::: "r7");
        num = 0x1e;
        ref = *(s16 *)(gB + num);
        num = ref * 24;
        ref = *(s16 *)(gA + 4) - 11;
    }
    ref = __divsi3(num - ref, hi - lo);
    num = ref + *(u16 *)(gA + 4);
    *(u16 *)(gA + 4) = num;

    gB2 = gB;
    if (*(vu8 *)(gB2 + 0x1a) != 0) {
        num = *(vu8 *)(gB2 + 0x1a);
        e = (u8 *)(num * 0x38);
        e += (s32)gA;
        num = *(s16 *)(e + 2);
        num += *(s16 *)(e + 0x24);
        ref = *(s16 *)(gA + 2);
    } else {
        asm("" ::: "r7");
        num = 0x1c;
        ref = *(s16 *)(gB + num);
        num = ref * 24;
        ref = *(s16 *)(gA + 2) - 11;
    }
    ref = __divsi3(num - ref, hi - lo);
    num = ref + *(u16 *)(gA + 2);
    *(u16 *)(gA + 2) = num;
}

/* sub_0800885C — directional area attack. Switches on the dispatch state
 * gEntities[0].field_1A (cases 12..15) to fill an axis-aligned box via
 * sub_080089A4, then walks the active-entity index table for the first
 * record (kind 11) whose centre falls strictly inside the box, latches it
 * (record+0x34 |= 0x84) and returns 1. */

struct IndexEntry {
    u8 id;
    u8 _pad[7];
};

extern struct Entity gEntities_03003720[];
extern struct IndexEntry gEntityIndex_03006160[];
extern void sub_080089A4(u8 sel, s8 d1, s8 d2, s8 d3, s16 *x0, s16 *x1, s16 *y0, s16 *y1);

u8 sub_0800885C(u8 arg0, u8 arg1)
{
    s8 a = (s8)arg0;
    s8 b = (s8)arg1;
    s16 xLo;
    s16 xHi;
    s16 yLo;
    s16 yHi;
    s32 i;

    switch (gEntities[0].field_1A) {
    case 12:
        sub_080089A4(0, b, a, b, &xLo, &xHi, &yLo, &yHi);
        break;
    case 13:
        sub_080089A4(1, b, a, b, &xLo, &xHi, &yLo, &yHi);
        break;
    case 14:
        sub_080089A4(2, a, a, b, &xLo, &xHi, &yLo, &yHi);
        break;
    case 15:
        sub_080089A4(3, a, a, b, &xLo, &xHi, &yLo, &yHi);
        break;
    }

    for (i = 0; i < gIwram_6110.liveCount; i++) {
        u8 id = gEntityIndex_03006160[i].id;
        struct Entity *e;
        /* base pinned to r3 (a caller-saved scratch the box-coord ldrsh reads
         * reuse as their index) so the record-array base materialises into the
         * same register the baserom recomputes each iteration. */
        register u8 *base asm("r3");
        u16 flags;

        if (id == 0)
            continue;

        base = (u8 *)gEntities_03003720;
        e = (struct Entity *)(id * sizeof(struct Entity) + (u32)base);
        flags = e->status;
        if (flags & 4)
            continue;
        if (((struct Entity *)base)->field_06 != e->field_06)
            continue;
        if (e->x <= yLo)
            continue;
        if (e->x >= yHi)
            continue;
        if (e->y <= xLo)
            continue;
        if (e->y >= xHi)
            continue;
        if (e->field_00 == 11) {
            /* The latch is `0x80 | flags | 4`. Pinning the accumulator to r0
             * keeps it a fresh 0x80 (not a reuse of flags' callee-saved reg),
             * which both stops agbcc folding 0x80|4 into 0x84 and lets flags
             * stay read-only in r5 — reproducing the baserom's r4/r5 colouring. */
            register u16 v asm("r0") = 0x80 | flags;
            e->status = v | 4;
            return 1;
        }
    }

    return 0;
}
