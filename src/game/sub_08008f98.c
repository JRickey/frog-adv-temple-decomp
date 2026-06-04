#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08008F98 — hit-test the player header against the active 56-byte
 * entity records.
 *
 * Walks the active-entity index table at 0x03006160 (8-byte stride, first
 * byte = signed record id) for the gIwram_6110[0x31] live entries. For each
 * non-zero id it fetches the entity record at gIwram_3720[id] (stride 0x38)
 * and skips it unless: bit 0x04 is clear in record+0x34, record+6 equals the
 * player header byte at gIwram_3720+6, and the player header coords
 * (gIwram_3720+{2,4}) fall inside the record's axis-aligned box
 *   y in [(h2+h24) - (b28>>1), (h2+h24) + (b28>>1)]
 *   x in [(h4+h26) -  b29,     (h4+h26)            ]
 * (signed s16 comparisons). The first record that also has record+1 == 2
 * latches its table id into gIwram_35E0+0x1A and returns.
 *
 * Shipped NAKED. The loop pins the player header base (gIwram_3720) in r8,
 * the index-table base reload guard (gIwram_6110) in r9, the player header
 * Y coord in sl, and the unsigned table id in ip across the whole body so
 * the per-iteration math never reloads the pool literals. agbcc 2.x will not
 * hold loop state in r8-r10/ip and recomputes the bases from low registers
 * instead, so the high-reg save pair and `mov rN, r8/r9/sl/ip` forms cannot
 * be reproduced from pure C. This is the docs/codegen-notes.md "High
 * registers" (Class 1) unmatchable pattern — the same shape as the sibling
 * sub_08007228 in src/game/sub_08007228.c. The NON_MATCHING body documents
 * intent for the phase-3 PC port. */

#ifdef NON_MATCHING

struct IndexEntry {
    s8 id;
    u8 _pad[7];
};

extern struct Entity gEntities_03003720[];
extern struct IndexEntry gEntityIndex_03006160[];

void sub_08008F98(void)
{
    s16 headerY = gEntities[0].x;
    s16 headerX = gEntities[0].y;
    s32 i;

    for (i = 0; i < (s8)gIwram_6110.liveCount; i++) {
        struct IndexEntry *slot = &gEntityIndex_03006160[i];
        u8 rawId = (u8)slot->id;
        s8 id = slot->id;
        struct Entity *e;
        s16 left, right, top, bottom;

        if (id == 0)
            continue;

        e = &gEntities_03003720[id];

        if (e->status & 4)
            continue;
        if (gEntities[0].field_06 != e->field_06)
            continue;

        right = (u16)(e->y + e->field_26);
        left = (u16)((e->y + e->field_26) - e->field_29);
        bottom = (u16)((e->x + e->field_24) + (e->field_28 >> 1));
        top = (e->x + e->field_24) - (e->field_28 >> 1);

        if (headerY < top)
            continue;
        if (headerY > bottom)
            continue;
        if (headerX < left)
            continue;
        if (headerX > right)
            continue;
        if (e->field_01 != 2)
            continue;

        gIwram_35E0._field_1A = rawId;
        return;
    }
}
#else
NAKED void sub_08008F98(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #4\n"
        "    ldr     r0, _pool_3720\n"
        "    ldrh    r1, [r0, #2]\n"
        "    str     r1, [sp, #0]\n"
        "    ldrh    r2, [r0, #4]\n"
        "    mov     sl, r2\n"
        "    movs    r1, #0\n"
        "    ldr     r2, _pool_6110\n"
        "    adds    r3, r2, #0\n"
        "    adds    r3, #49\n"
        "    mov     r8, r0\n"
        "    mov     r9, r2\n"
        "    ldrb    r3, [r3, #0]\n"
        "    cmp     r1, r3\n"
        "    bge     _8F98_end\n"
        "_8F98_loop:\n"
        "    lsls    r1, r1, #24\n"
        "    asrs    r0, r1, #21\n"
        "    ldr     r4, _pool_6160\n"
        "    adds    r0, r0, r4\n"
        "    ldrb    r2, [r0, #0]\n"
        "    mov     ip, r2\n"
        "    movs    r2, #0\n"
        "    ldrsb   r2, [r0, r2]\n"
        "    adds    r7, r1, #0\n"
        "    cmp     r2, #0\n"
        "    beq     _8F98_cont\n"
        "    lsls    r0, r2, #3\n"
        "    subs    r0, r0, r2\n"
        "    lsls    r0, r0, #3\n"
        "    ldr     r4, _pool_3720\n"
        "    adds    r3, r0, r4\n"
        "    movs    r0, #4\n"
        "    ldrh    r1, [r3, #52]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _8F98_cont\n"
        "    mov     r2, r8\n"
        "    ldrb    r2, [r2, #6]\n"
        "    ldrb    r4, [r3, #6]\n"
        "    cmp     r2, r4\n"
        "    bne     _8F98_cont\n"
        "    ldrh    r0, [r3, #4]\n"
        "    ldrh    r2, [r3, #38]\n"
        "    adds    r1, r0, r2\n"
        "    adds    r0, r3, #0\n"
        "    adds    r0, #41\n"
        "    ldrb    r0, [r0, #0]\n"
        "    subs    r0, r1, r0\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r5, r0, #16\n"
        "    lsls    r1, r1, #16\n"
        "    lsrs    r6, r1, #16\n"
        "    ldrh    r4, [r3, #2]\n"
        "    ldrh    r0, [r3, #36]\n"
        "    adds    r2, r4, r0\n"
        "    adds    r0, r3, #0\n"
        "    adds    r0, #40\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsrs    r0, r0, #1\n"
        "    subs    r1, r2, r0\n"
        "    adds    r0, r0, r2\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r2, r0, #16\n"
        "    ldr     r4, [sp, #0]\n"
        "    lsls    r0, r4, #16\n"
        "    lsls    r1, r1, #16\n"
        "    asrs    r4, r0, #16\n"
        "    cmp     r0, r1\n"
        "    blt     _8F98_cont\n"
        "    lsls    r0, r2, #16\n"
        "    asrs    r0, r0, #16\n"
        "    cmp     r4, r0\n"
        "    bgt     _8F98_cont\n"
        "    mov     r1, sl\n"
        "    lsls    r0, r1, #16\n"
        "    lsls    r1, r5, #16\n"
        "    asrs    r2, r0, #16\n"
        "    cmp     r0, r1\n"
        "    blt     _8F98_cont\n"
        "    lsls    r0, r6, #16\n"
        "    asrs    r0, r0, #16\n"
        "    cmp     r2, r0\n"
        "    bgt     _8F98_cont\n"
        "    ldrb    r3, [r3, #1]\n"
        "    cmp     r3, #2\n"
        "    bne     _8F98_cont\n"
        "    mov     r4, ip\n"
        "    ldr     r2, _pool_35e0\n"
        "    strb    r4, [r2, #26]\n"
        "    b       _8F98_end\n"
        "    .align  2, 0\n"
        "_pool_3720: .4byte 0x03003720\n"
        "_pool_6110: .4byte 0x03006110\n"
        "_pool_6160: .4byte 0x03006160\n"
        "_pool_35e0: .4byte 0x030035e0\n"
        "_8F98_cont:\n"
        "    movs    r1, #128\n"
        "    lsls    r1, r1, #17\n"
        "    adds    r0, r7, r1\n"
        "    lsrs    r1, r0, #24\n"
        "    asrs    r0, r0, #24\n"
        "    mov     r2, r9\n"
        "    adds    r2, #49\n"
        "    ldrb    r2, [r2, #0]\n"
        "    cmp     r0, r2\n"
        "    blt     _8F98_loop\n"
        "_8F98_end:\n"
        "    add     sp, #4\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif

extern u8 sub_08007F88(void);

u8 sub_0800908C(void)
{
    if (sub_08007F88()) {
        sub_08006B94(&gIwram_35E0, 1);
        return 1;
    }
    return 0;
}
