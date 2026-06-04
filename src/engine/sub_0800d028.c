#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

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
 *
 * Ships NAKED + #ifdef NON_MATCHING — class3-libgcc: wide prologue
 * `push {r4-r7, lr}` + all BLs are libgcc helpers (__divsi3, __modsi3).
 * agbcc 2.x knows libgcc helpers don't clobber r4-r7 and emits a narrower
 * prologue; the baserom uses the full r4-r7 save, which is unmatchable.
 * Corpus: no pure-C precedent for __divsi3 with wide prologue found.
 * class: class3, corpus: 0 C hits for __divsi3 pattern, levers tried: none.
 */
#ifdef NON_MATCHING
u32 *sub_0800D070(u32 *out, s8 delta)
{
    u8 *base = (u8 *)gEntities;
    s16 lo = *(u16 *)(base + 0x692) - 2;
    s16 hi = *(u16 *)(base + 0x694) - 2;

    lo = (s8)(lo + (s8)__modsi3(delta, 5));
    hi = (s8)(hi + (s8)__divsi3(delta, 5));

    *out = ((u16)lo & 0xffff) | ((u16)hi << 16);
    return out;
}
#else
NAKED u32 *sub_0800D070(u32 *out, s8 delta)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, r9\n"
        "    mov     r6, r8\n"
        "    push    {r6, r7}\n"
        "    mov     r8, r0\n"
        "    ldr     r2, _0800D070_pool_base\n"
        "    ldr     r3, _0800D070_pool_692\n"
        "    adds    r0, r2, r3\n"
        "    ldrh    r3, [r0, #0]\n"
        "    subs    r3, #2\n"
        "    lsls    r3, r3, #16\n"
        "    ldr     r0, _0800D070_pool_mask_hi\n"
        "    mov     r9, r0\n"
        "    ldr     r0, _0800D070_pool_694\n"
        "    adds    r2, r2, r0\n"
        "    ldrh    r0, [r2, #0]\n"
        "    subs    r0, #2\n"
        "    lsls    r0, r0, #16\n"
        "    ldr     r6, _0800D070_pool_mask_lo\n"
        "    lsrs    r7, r3, #16\n"
        "    orrs    r7, r0\n"
        "    lsls    r5, r1, #24\n"
        "    asrs    r5, r5, #24\n"
        "    adds    r0, r5, #0\n"
        "    movs    r1, #5\n"
        "    bl      __divsi3\n"
        "    adds    r4, r0, #0\n"
        "    lsls    r4, r4, #24\n"
        "    lsrs    r4, r4, #24\n"
        "    adds    r0, r5, #0\n"
        "    movs    r1, #5\n"
        "    bl      __modsi3\n"
        "    asrs    r1, r7, #16\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    adds    r4, r4, r1\n"
        "    lsls    r4, r4, #16\n"
        "    ands    r7, r6\n"
        "    orrs    r7, r4\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    adds    r0, r0, r7\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    mov     r1, r9\n"
        "    ands    r7, r1\n"
        "    orrs    r7, r0\n"
        "    mov     r3, r8\n"
        "    str     r7, [r3, #0]\n"
        "    mov     r0, r8\n"
        "    pop     {r3, r4}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "    .align  2, 0\n"
        "_0800D070_pool_base:    .4byte 0x03003720\n"
        "_0800D070_pool_692:     .4byte 0x00000692\n"
        "_0800D070_pool_mask_hi: .4byte 0xffff0000\n"
        "_0800D070_pool_694:     .4byte 0x00000694\n"
        "_0800D070_pool_mask_lo: .4byte 0x0000ffff\n"
        "    .syntax divided\n");
}
#endif
