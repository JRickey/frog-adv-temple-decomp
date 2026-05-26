#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Searches a 5-entry (X, Y) lookup table at ROM 0x082f9cf4 for a coord
 * pair matching (s16)gIwram_35E0._field_8 / (u16)gIwram_35E0._field_A.
 * Returns 0 if no match or if the pendingMode/flag gates are not set;
 * otherwise returns the 1-based match index (after a side-effect call to
 * sub_08020C78(8)).
 *
 * Gates:
 *   - gGameStuff.pendingMode (offset 10) must be 1
 *   - *(u8*)(0x03006110 + 0x32) must be 1
 *
 * Shipped NAKED. The baserom caches the ROM table base into the high
 * register `ip` (r12) via `mov ip, r3` and reads it back inside the
 * loop via `mov r7, ip`. Per docs/codegen-notes.md "High registers
 * (sl/r10, sb/r9, r8) — corpus-validated unmatchable", agbcc 2.x's
 * register allocator will not promote a value into a high register
 * (r8-r12) from any plausible C input. Corpus search across 7 agbcc
 * decomps confirms `mov ip, rN` only appears inside NAKED inline-asm
 * blocks — no matched C body ever produces it. Pure-C attempt
 * converged at byte_diff=88 of 104 with the table-base load in a
 * low register; the high-register fold is unreachable.
 *
 * The reference body in the NON_MATCHING block documents intent for
 * the phase-3 PC port.
 */

extern void sub_08020C78(u32 a);

struct CoordEntry {
    s16 x;
    u16 y;
};

#ifdef NON_MATCHING
u8 sub_08009BA0(void)
{
    const struct CoordEntry *table = (const struct CoordEntry *)0x082f9cf4;
    u8 match = 0;
    s16 needleX;
    u16 needleY;
    u8 i;

    if (gGameStuff.pendingMode != 1)
        goto end;
    if (*(u8 *)(0x03006110 + 0x32) != 1)
        goto end;

    needleX = (s16)gIwram_35E0._field_8;
    i = 0;
    do {
        u8 cur = i;
        i = (u8)(i + 1);
        if (needleX != table[cur].x)
            continue;
        needleY = gIwram_35E0._field_A;
        if (needleY != table[cur].y)
            continue;
        match = i;
    } while (i <= 4);

end:
    if (match == 0)
        return 0;
    sub_08020C78(8);
    return match;
}
#else
NAKED u8 sub_08009BA0(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    movs    r6, #0\n"
        "    ldr     r0, _pool_gGameStuff\n"
        "    ldrb    r0, [r0, #10]\n"
        "    cmp     r0, #1\n"
        "    bne     _sub_08009BA0_check\n"
        "    ldr     r0, _pool_iwram_6110\n"
        "    adds    r0, #50\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #1\n"
        "    bne     _sub_08009BA0_check\n"
        "    movs    r2, #0\n"
        "    ldr     r4, _pool_iwram_35E0\n"
        "    ldr     r3, _pool_table_82F9CF4\n"
        "    mov     ip, r3\n"
        "    movs    r0, #8\n"
        "    ldrsh   r5, [r4, r0]\n"
        "_sub_08009BA0_loop:\n"
        "    lsls    r1, r2, #2\n"
        "    mov     r7, ip\n"
        "    adds    r0, r1, r7\n"
        "    movs    r7, #0\n"
        "    ldrsh   r0, [r0, r7]\n"
        "    adds    r2, #1\n"
        "    cmp     r5, r0\n"
        "    bne     _sub_08009BA0_step\n"
        "    adds    r0, r3, #2\n"
        "    adds    r0, r1, r0\n"
        "    ldrh    r1, [r4, #10]\n"
        "    ldrh    r0, [r0, #0]\n"
        "    cmp     r1, r0\n"
        "    bne     _sub_08009BA0_step\n"
        "    lsls    r0, r2, #24\n"
        "    lsrs    r6, r0, #24\n"
        "_sub_08009BA0_step:\n"
        "    lsls    r0, r2, #24\n"
        "    lsrs    r2, r0, #24\n"
        "    cmp     r2, #4\n"
        "    bls     _sub_08009BA0_loop\n"
        "_sub_08009BA0_check:\n"
        "    lsls    r4, r6, #24\n"
        "    cmp     r4, #0\n"
        "    bne     _sub_08009BA0_match\n"
        "    movs    r0, #0\n"
        "    b       _sub_08009BA0_ret\n"
        "    .align  2, 0\n"
        "_pool_gGameStuff:    .4byte 0x03005330\n"
        "_pool_iwram_6110:    .4byte 0x03006110\n"
        "_pool_iwram_35E0:    .4byte 0x030035e0\n"
        "_pool_table_82F9CF4: .4byte 0x082f9cf4\n"
        "_sub_08009BA0_match:\n"
        "    movs    r0, #8\n"
        "    bl      sub_08020C78\n"
        "    lsrs    r0, r4, #24\n"
        "_sub_08009BA0_ret:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "    .align  2, 0\n"
        "    .syntax divided\n");
}
#endif
