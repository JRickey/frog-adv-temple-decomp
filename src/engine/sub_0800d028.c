#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern s32 __divsi3(s32 num, s32 den);
extern s32 __modsi3(s32 num, s32 den);

/* AABB proximity test between the reference entity (gIwram_3720[0]) and
 * entity `idx` in the stride-0x38 entity array. Returns 1 when the
 * entity lies within a 0x104 (X) by 0xB4 (Y) half-window of the
 * reference, else 0. Called per-entity from sub_08009A58. */
u32 sub_0800D028(s32 idx)
{
    s32 refX;
    u8 *entity;
    s32 delta;

    refX = gEntities[0].x;
    entity = (u8 *)gEntities + idx * 0x38;

    delta = refX - *(s16 *)(entity + 2);
    if (delta < 0)
        delta = *(s16 *)(entity + 2) - refX;
    if (delta > 0x104)
        return 0;

    delta = gEntities[0].y - *(s16 *)(entity + 4);
    if (delta < 0)
        delta = *(s16 *)(entity + 4) - gEntities[0].y;
    if (delta > 0xb4)
        return 0;

    return 1;
}

/* Packs a tile-coord pair into a single u32 for the frog's position,
 * applying a signed delta split across the two axes by div/mod 5.
 *
 * Reads two u16 fields at gIwram_3720+0x692 and +0x694, subtracts 2 from
 * each, then: low 16 of *out = (field_692-2) + (delta % 5),
 *             high 16 of *out = (field_694-2) + (delta / 5).
 * Returns out.
 */
u32 *sub_0800D070(u32 *out, s8 delta)
{
    u32 *outp;
    u32 hiMask;
    u32 loMask;
    s32 sdelta;
    u8 *base;
    u32 loShift;
    u32 hiShift;
    u32 packed;
    s32 lane;
    s32 divResult;
    register s32 remainder asm("r0");

    outp = out;
    base = (u8 *)0x03003720;
    loShift = (*(u16 *)(base + 0x692) - 2) << 16;
    hiMask = 0xffff0000;
    hiShift = (*(u16 *)(base + 0x694) - 2) << 16;
    loMask = 0x0000ffff;
    packed = (loShift >> 16) | hiShift;
    sdelta = delta;
    sdelta <<= 24;
    sdelta >>= 24;

    divResult = __divsi3(sdelta, 5);
    {
        s32 quotient = divResult;
        u8 qByte;

        qByte = quotient;
        quotient = qByte;
        remainder = __modsi3(sdelta, 5);

        lane = (s32)packed >> 16;
        quotient = (s8)quotient + lane;
        packed = (quotient << 16) | (packed & loMask);

        remainder = (s8)remainder + packed;
        remainder <<= 16;
        remainder = (u32)remainder >> 16;
        packed &= hiMask;
        packed |= remainder;
    }

    {
        u32 *storep;

        storep = outp;
        *storep = packed;
    }
    return outp;
}
