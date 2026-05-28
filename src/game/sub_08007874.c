#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08006A74(struct IwramAt35E0 *p, s8 a, s16 b, s8 c, s8 e);
extern void sub_0800A710(struct IwramAt3720 *p, u8 a, s16 b, s16 c, u8 d, u16 e, u8 f, u8 g, u8 h, u16 i);

struct SpawnRec {
    s16 _h0;
    s16 _h2;
    u8 _b4;
    u8 _b5;
    u8 _b6;
    u8 _b7;
    u8 _b8;
};

/* gIwram_6110 +0x34 holds a base pointer into a table of SpawnRec arrays; the
 * state byte at +0x32 selects which array (one back), and `id` indexes into
 * the chosen array. The record's two leading halfwords become tile-to-pixel
 * positions (n*24 + 11) seeded into gIwram_35E0 / forwarded to sub_0800A710,
 * while sub_08006A74 re-reads the bytes just stored into gIwram_35E0.
 *
 * NAKED + NON_MATCHING: documented unmatchable Class 1 (high-register pins).
 * The baserom reads the record's +4/+5/+6 bytes up front and pins them in
 * sl/r8/r9 across the sub_08006A74 call so they survive as the d/g/h args to
 * sub_0800A710; agbcc 2.x will not hold call-surviving values in r8-r10 and
 * instead re-loads them, so the high-reg save pair and `mov rN, r8/r9/sl`
 * forms cannot be reproduced from pure C. See docs/codegen-notes.md
 * "High registers". */

#ifdef NON_MATCHING
void sub_08007874(u8 id)
{
    struct SpawnRec *rec =
        (struct SpawnRec *)((const struct SpawnRec **)gIwram_6110._field_34)[gIwram_6110._field_32 - 1] + (s8)id;
    s16 px = rec->_h0 * 24 + 11;
    s16 py = rec->_h2 * 24 + 11;
    u8 b4 = rec->_b4;
    u8 b5 = rec->_b5;
    u8 b6 = rec->_b6;

    gIwram_35E0._field_8 = (u16)rec->_h0;
    gIwram_35E0._field_A = (u16)rec->_h2;
    gIwram_35E0._field_18 = rec->_b7;
    gIwram_35E0._field_19 = rec->_b8;

    sub_08006A74(&gIwram_35E0, (s8)gIwram_35E0._data[0], *(s16 *)&gIwram_35E0._data[2], (s8)gIwram_35E0._data[4],
                 gIwram_35E0._field_5);

    sub_0800A710(&gIwram_3720, 0, px, py, b5, 1, 0, b6, b4, 16);
}
#else
NAKED void sub_08007874(u8 id)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #24\n"
        "    ldr     r1, _pool_6110\n"
        "    adds    r2, r1, #0\n"
        "    adds    r2, #50\n"
        "    ldr     r1, [r1, #52]\n"
        "    ldrb    r2, [r2, #0]\n"
        "    lsls    r2, r2, #2\n"
        "    adds    r2, r2, r1\n"
        "    subs    r2, #4\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    lsls    r1, r0, #1\n"
        "    adds    r1, r1, r0\n"
        "    lsls    r1, r1, #2\n"
        "    ldr     r2, [r2, #0]\n"
        "    adds    r2, r2, r1\n"
        "    movs    r1, #0\n"
        "    ldrsh   r0, [r2, r1]\n"
        "    lsls    r6, r0, #1\n"
        "    adds    r6, r6, r0\n"
        "    lsls    r6, r6, #19\n"
        "    movs    r3, #176\n"
        "    lsls    r3, r3, #12\n"
        "    adds    r6, r6, r3\n"
        "    lsrs    r6, r6, #16\n"
        "    movs    r1, #2\n"
        "    ldrsh   r0, [r2, r1]\n"
        "    lsls    r5, r0, #1\n"
        "    adds    r5, r5, r0\n"
        "    lsls    r5, r5, #19\n"
        "    adds    r5, r5, r3\n"
        "    lsrs    r5, r5, #16\n"
        "    ldr     r0, _pool_35e0\n"
        "    ldrh    r1, [r2, #0]\n"
        "    movs    r7, #0\n"
        "    strh    r1, [r0, #8]\n"
        "    ldrh    r1, [r2, #2]\n"
        "    strh    r1, [r0, #10]\n"
        "    ldrb    r3, [r2, #5]\n"
        "    mov     r8, r3\n"
        "    ldrb    r1, [r2, #6]\n"
        "    mov     r9, r1\n"
        "    ldrb    r3, [r2, #4]\n"
        "    mov     sl, r3\n"
        "    ldrb    r1, [r2, #7]\n"
        "    strb    r1, [r0, #24]\n"
        "    ldrb    r1, [r2, #8]\n"
        "    strb    r1, [r0, #25]\n"
        "    movs    r1, #0\n"
        "    ldrsb   r1, [r0, r1]\n"
        "    movs    r3, #2\n"
        "    ldrsh   r2, [r0, r3]\n"
        "    movs    r3, #4\n"
        "    ldrsb   r3, [r0, r3]\n"
        "    movs    r4, #5\n"
        "    ldrsb   r4, [r0, r4]\n"
        "    str     r4, [sp, #0]\n"
        "    bl      sub_08006A74\n"
        "    ldr     r0, _pool_3720\n"
        "    lsls    r6, r6, #16\n"
        "    asrs    r6, r6, #16\n"
        "    lsls    r5, r5, #16\n"
        "    asrs    r5, r5, #16\n"
        "    mov     r1, r8\n"
        "    str     r1, [sp, #0]\n"
        "    movs    r1, #1\n"
        "    str     r1, [sp, #4]\n"
        "    str     r7, [sp, #8]\n"
        "    mov     r3, r9\n"
        "    str     r3, [sp, #12]\n"
        "    mov     r1, sl\n"
        "    str     r1, [sp, #16]\n"
        "    movs    r1, #16\n"
        "    str     r1, [sp, #20]\n"
        "    movs    r1, #0\n"
        "    adds    r2, r6, #0\n"
        "    adds    r3, r5, #0\n"
        "    bl      sub_0800A710\n"
        "    add     sp, #24\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_6110: .4byte gIwram_6110\n"
        "_pool_35e0: .4byte gIwram_35E0\n"
        "_pool_3720: .4byte gIwram_3720\n"
        "    .syntax divided\n");
}
#endif
