#include "macros.h"
#include "types.h"

/* Expands one entry of the part-descriptor table at 0x080C0AB0 into a run of
 * 36-byte (0x24) output records. Companion to sub_08006BB4
 * (src/game/sub_08006b88.c), which operates on the same table; this variant
 * skips the per-record layout switch, always uses the raw `byte * 24` X/Y
 * origin, zeroes the two flag bytes at out+25/out+26, and stamps the caller's
 * `tag` byte into out+27.
 *
 * Shipped NAKED. The loop pins the table base in r8, the byte `tag` in r9,
 * the sign-extended index source (`partId << 24`) in sl, and the constant 0
 * in ip across the whole body so the per-iteration index math never reloads
 * the pool literal. agbcc 2.x will not hold loop state in r8-r10/ip and
 * recomputes the bases from low registers instead, so the high-reg save pair
 * and `add rN, r8/r9/sl/ip` forms cannot be reproduced from pure C. This is
 * the docs/codegen-notes.md "High registers" (Class 1) unmatchable pattern;
 * the NON_MATCHING body documents intent for the phase-3 PC port.
 */

#ifdef NON_MATCHING
struct SrcRec {
    s16 _h0;
    s16 _h2;
    s8 _b4;
    s8 _b5;
    u8 _pad[2];
    u8 _b8;
    u8 _b9;
    u8 _pad0A[2];
    u32 _w12;
};

struct PartEntry {
    s8 count;
    u8 _b1;
    u8 _pad[2];
    const struct SrcRec *records;
};

extern const struct PartEntry gPartTable_080C0AB0[];

void sub_08007228(u8 partId, u8 *out, u8 tag)
{
    s8 id = (s8)partId;
    const struct PartEntry *entry = &gPartTable_080C0AB0[id];
    const struct SrcRec *records = entry->records;
    s32 i;

    for (i = 0; i < entry->count; i++) {
        struct SrcRec s = records[i];

        *(s16 *)(out + 0) = s._h0;
        *(s16 *)(out + 2) = s._h2;
        *(s16 *)(out + 4) = s._b4 * 24;
        *(s16 *)(out + 6) = s._b5 * 24;
        out[18] = s._b8;
        out[24] = s._b9;
        out[26] = 0;
        out[28] = (u8)(s._b4 * s._b5);
        *(u32 *)(out + 32) = s._w12;
        out[8] = entry->_b1;
        out[25] = 0;
        out[27] = tag;

        out += 0x24;
    }
}
#else
NAKED void sub_08007228(u8 partId, u8 *out, u8 tag)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #20\n"
        "    lsls    r2, r2, #24\n"
        "    lsrs    r2, r2, #24\n"
        "    mov     r9, r2\n"
        "    movs    r6, #0\n"
        "    ldr     r2, _pool_part_table\n"
        "    lsls    r0, r0, #24\n"
        "    mov     sl, r0\n"
        "    asrs    r0, r0, #21\n"
        "    adds    r0, r0, r2\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    cmp     r6, r0\n"
        "    bge     _epilogue_7228\n"
        "    mov     r8, r2\n"
        "    mov     r5, sp\n"
        "    movs    r0, #0\n"
        "    mov     ip, r0\n"
        "    adds    r4, r1, #0\n"
        "_loop_body_7228:\n"
        "    mov     r1, sl\n"
        "    asrs    r1, r1, #21\n"
        "    str     r1, [sp, #16]\n"
        "    mov     r0, r8\n"
        "    adds    r0, #4\n"
        "    adds    r0, r1, r0\n"
        "    ldr     r2, [r0, #0]\n"
        "    lsls    r0, r6, #4\n"
        "    mov     r1, sp\n"
        "    adds    r0, r0, r2\n"
        "    ldmia   r0!, {r2, r3, r7}\n"
        "    stmia   r1!, {r2, r3, r7}\n"
        "    ldr     r0, [r0, #0]\n"
        "    str     r0, [r1, #0]\n"
        "    ldrh    r0, [r5, #0]\n"
        "    strh    r0, [r4, #0]\n"
        "    ldrh    r0, [r5, #2]\n"
        "    strh    r0, [r4, #2]\n"
        "    movs    r1, #4\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    strh    r0, [r4, #4]\n"
        "    movs    r1, #5\n"
        "    ldrsb   r1, [r5, r1]\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    lsls    r0, r0, #3\n"
        "    strh    r0, [r4, #6]\n"
        "    ldrb    r0, [r5, #8]\n"
        "    strb    r0, [r4, #18]\n"
        "    ldrb    r0, [r5, #9]\n"
        "    strb    r0, [r4, #24]\n"
        "    mov     r0, ip\n"
        "    strb    r0, [r4, #26]\n"
        "    ldrb    r1, [r5, #4]\n"
        "    ldrb    r2, [r5, #5]\n"
        "    adds    r0, r1, #0\n"
        "    muls    r0, r2\n"
        "    strb    r0, [r4, #28]\n"
        "    ldr     r0, [sp, #12]\n"
        "    str     r0, [r4, #32]\n"
        "    ldr     r3, [sp, #16]\n"
        "    add     r3, r8\n"
        "    ldrb    r0, [r3, #1]\n"
        "    strb    r0, [r4, #8]\n"
        "    mov     r7, ip\n"
        "    strb    r7, [r4, #25]\n"
        "    mov     r0, r9\n"
        "    strb    r0, [r4, #27]\n"
        "    adds    r4, #36\n"
        "    adds    r6, #1\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r3, r0]\n"
        "    cmp     r6, r0\n"
        "    blt     _loop_body_7228\n"
        "_epilogue_7228:\n"
        "    add     sp, #20\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_part_table: .4byte 0x080C0AB0\n"
        "    .syntax divided\n");
}
#endif
