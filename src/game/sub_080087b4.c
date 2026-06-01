#include "iwram.h"
#include "macros.h"
#include "types.h"

extern int __divsi3(int num, int den);

void sub_080087B4(void)
{
    u8 *gA0 = (u8 *)&gIwram_3720;
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
