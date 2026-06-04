#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Checks whether the tile coordinates derived from a struct's sub-pixel
 * fields (s16 at offsets +2 and +4, divided by 24) fall within a
 * Manhattan-style bounding box centred on gIwram_35E0's cached tile
 * coords (_field_8, _field_A).  Returns 1 if both |dx| <= halfW and
 * |dy| <= halfH, 0 otherwise.
 *
 * Shipped NAKED. Class-3 (wide prologue + libgcc):  the baserom emits
 * push {r4, r5, r6, r7, lr} but both BL targets are __divsi3 (a libgcc
 * helper). agbcc 2.x knows __divsi3 does not clobber r4-r7 and shrinks
 * the prologue accordingly, so the wide save cannot be reproduced from
 * pure C. See docs/codegen-notes.md "Third unmatchable class". */

#ifdef NON_MATCHING
u8 sub_08021E34(struct Entity *s, u8 halfW, u8 halfH)
{
    s16 tileX = (s16)((s16)s->x / 24);
    s16 tileY = (s16)((s16)s->y / 24);
    u16 dx;
    u16 dy;

    if (gIwram_35E0._field_8 - tileX >= 0)
        dx = (u16)(gIwram_35E0._field_8 - tileX);
    else
        dx = (u16)(tileX - gIwram_35E0._field_8);

    if (gIwram_35E0._field_A - tileY >= 0)
        dy = (u16)(gIwram_35E0._field_A - tileY);
    else
        dy = (u16)(tileY - gIwram_35E0._field_A);

    if ((s16)dx > halfW)
        return 0;
    if ((s16)dy > halfH)
        return 0;
    return 1;
}
#else
NAKED u8 sub_08021E34(struct Entity *s, u8 halfW, u8 halfH)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    adds    r5, r0, #0\n"
        "    lsls    r1, r1, #24\n"
        "    lsrs    r6, r1, #24\n"
        "    lsls    r2, r2, #24\n"
        "    lsrs    r7, r2, #24\n"
        "    movs    r1, #2\n"
        "    ldrsh   r0, [r5, r1]\n"
        "    movs    r1, #24\n"
        "    bl      __divsi3\n"
        "    adds    r4, r0, #0\n"
        "    lsls    r4, r4, #16\n"
        "    lsrs    r4, r4, #16\n"
        "    movs    r2, #4\n"
        "    ldrsh   r0, [r5, r2]\n"
        "    movs    r1, #24\n"
        "    bl      __divsi3\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r3, r0, #16\n"
        "    ldr     r1, _08021e78\n"
        "    movs    r2, #8\n"
        "    ldrsh   r0, [r1, r2]\n"
        "    lsls    r4, r4, #16\n"
        "    asrs    r4, r4, #16\n"
        "    subs    r0, r0, r4\n"
        "    adds    r2, r1, #0\n"
        "    cmp     r0, #0\n"
        "    blt     _08021e7c\n"
        "    ldrh    r1, [r2, #8]\n"
        "    subs    r0, r1, r4\n"
        "    b       _08021e80\n"
        "    movs    r0, r0\n"
        "_08021e78: .4byte gIwram_35E0\n"
        "_08021e7c:\n"
        "    ldrh    r1, [r2, #8]\n"
        "    subs    r0, r4, r1\n"
        "_08021e80:\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    adds    r4, r0, #0\n"
        "    movs    r1, #10\n"
        "    ldrsh   r0, [r2, r1]\n"
        "    lsls    r1, r3, #16\n"
        "    asrs    r1, r1, #16\n"
        "    subs    r0, r0, r1\n"
        "    cmp     r0, #0\n"
        "    blt     _08021e9a\n"
        "    ldrh    r2, [r2, #10]\n"
        "    subs    r0, r2, r1\n"
        "    b       _08021e9e\n"
        "_08021e9a:\n"
        "    ldrh    r2, [r2, #10]\n"
        "    subs    r0, r1, r2\n"
        "_08021e9e:\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r1, r0, #16\n"
        "    lsls    r0, r4, #16\n"
        "    asrs    r0, r0, #16\n"
        "    cmp     r0, r6\n"
        "    bgt     _08021eb6\n"
        "    lsls    r0, r1, #16\n"
        "    asrs    r0, r0, #16\n"
        "    cmp     r0, r7\n"
        "    bgt     _08021eb6\n"
        "    movs    r0, #1\n"
        "    b       _08021eb8\n"
        "_08021eb6:\n"
        "    movs    r0, #0\n"
        "_08021eb8:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "    .syntax divided\n");
}
#endif
