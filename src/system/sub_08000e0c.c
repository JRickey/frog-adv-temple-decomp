#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-entity tile-probe dispatch helper (sibling of sub_08000B6C).
 *
 * Same shape as iter-34's sub_08000B6C: per-entity probe-then-dispatch
 * structured around the same gIwram_3720 / gIwram_35E0 bases, with a
 * gEntities[0].status & 4 early-out gate followed by sub_0800CD88
 * tile-probe, a gIwram_35E0._field_10 & 0x10 secondary-dispatch gate,
 * and a sub_08006BA4 bit-test guard before four (coord, value) writes
 * to gEntities[0].field_06.
 *
 * Distinguishing features vs sub_08000B6C:
 *   - Kind constant is 3 (not 18).
 *   - Inside the &0x10 gate, calls sub_0800C358(tile) BEFORE sub_0800B8A8
 *     (which sub_08000B6C didn't have).
 *   - Trailing dispatch is a 4-way compare against the 32-bit value at
 *     gIwram_35E0._field_8 (read once as u32 into r2): 0x001c0006 -> 2,
 *     0x001c0007 -> 3, 0x001c000d -> 3, 0x001c000e -> 2. The first three
 *     compare r1 (the low-r2 alias), the fourth compares r2 directly.
 *
 * Shipped NAKED. Same high-register exception as sub_08000B6C: baserom
 * does `mov r8, r1` in the prologue to pin arg1 across sub_0800CD88 +
 * sub_0800C358 + sub_0800B8A8 + sub_08006BA4 BLs, and reads it back as
 * `mov r1, r8` before sub_0800B8A8's arg2 slot. Per docs/codegen-notes.md
 * "High registers (sl/r10, sb/r9, r8, ip/r12) — corpus-validated
 * unmatchable", agbcc 2.x will not promote a value to a high register
 * from any C input.
 *
 * Source variants attempted before NAKED (all hit byte_diff >= 12):
 *   1. Pure C with arg1 as plain parameter — agbcc keeps arg1 in r1 then
 *      spills to a low callee-saved register across the BL, NEVER to r8.
 *   2. Pinning `arg1_hi` to r8 — ignored by agbcc for
 *      high regs (corpus-validated).
 *   3. Re-order the early-out check before sub_0800B918 — wrong semantics
 *      (baserom always calls sub_0800B918 first).
 *   4. Cache gEntities in a `volatile` local — agbcc still chooses r6,
 *      not r8 — but the spurious volatile read reorders the ldrh.
 *   5. Pull the 4-way coord-compare into a switch over u32 — agbcc emits
 *      a chain of cmp/beq the same way as the if/if/if/if form, but
 *      shuffles the pool literal layout (pool offset diff).
 *
 * NON_MATCHING reference body documents the function's behaviour for
 * the phase-3 PC port. */

extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800C358(u8 tile);
extern u32 sub_08006BA4(void *p, u16 mask);

#ifdef NON_MATCHING
void sub_08000E0C(void *ent, u32 arg1)
{
    u8 tile;
    u32 coord;

    sub_0800B918(ent, arg1, 3);

    if ((gEntities[0].status & 4) != 0)
        return;

    tile = (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);

    if ((gIwram_35E0._field_10 & 0x10) != 0) {
        sub_0800C358(tile);
        sub_0800B8A8(ent, arg1, 3, tile);
    }

    if ((u8)sub_08006BA4(&gIwram_35E0, 0x40) == 0)
        return;

    coord = *(u32 *)((u8 *)&gIwram_35E0 + 8);
    if (coord == 0x001c0006)
        *((u8 *)gEntities + 6) = 2;
    if (coord == 0x001c0007)
        *((u8 *)gEntities + 6) = 3;
    if (coord == 0x001c000d)
        *((u8 *)gEntities + 6) = 3;
    if (coord == 0x001c000e)
        *((u8 *)gEntities + 6) = 2;
}
#else
NAKED void sub_08000E0C(void *ent, u32 arg1)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, r8\n"
        "    push    {r7}\n"
        "    adds    r7, r0, #0\n"
        "    mov     r8, r1\n"
        "    movs    r2, #3\n"
        "    bl      sub_0800B918\n"
        "    ldr     r6, _sub_08000E0C_pool_iwram_3720\n"
        "    movs    r0, #4\n"
        "    ldrh    r1, [r6, #52]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000E0C_epilogue\n"
        "    ldr     r4, _sub_08000E0C_pool_iwram_35E0\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r3, #8\n"
        "    ldrsh   r2, [r4, r3]\n"
        "    movs    r5, #10\n"
        "    ldrsh   r3, [r4, r5]\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r5, r0, #24\n"
        "    movs    r0, #16\n"
        "    ldrh    r1, [r4, #16]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000E0C_after_b8a8\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_0800C358\n"
        "    adds    r0, r7, #0\n"
        "    mov     r1, r8\n"
        "    movs    r2, #3\n"
        "    adds    r3, r5, #0\n"
        "    bl      sub_0800B8A8\n"
        "_sub_08000E0C_after_b8a8:\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #64\n"
        "    bl      sub_08006BA4\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000E0C_epilogue\n"
        "    ldr     r2, [r4, #8]\n"
        "    ldr     r0, _sub_08000E0C_pool_coord_a\n"
        "    adds    r1, r2, #0\n"
        "    cmp     r1, r0\n"
        "    bne     _sub_08000E0C_cmp_b\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #6]\n"
        "_sub_08000E0C_cmp_b:\n"
        "    ldr     r0, _sub_08000E0C_pool_coord_b\n"
        "    cmp     r1, r0\n"
        "    bne     _sub_08000E0C_cmp_c\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #6]\n"
        "_sub_08000E0C_cmp_c:\n"
        "    ldr     r0, _sub_08000E0C_pool_coord_c\n"
        "    cmp     r1, r0\n"
        "    bne     _sub_08000E0C_cmp_d\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r6, #6]\n"
        "_sub_08000E0C_cmp_d:\n"
        "    ldr     r0, _sub_08000E0C_pool_coord_d\n"
        "    cmp     r2, r0\n"
        "    bne     _sub_08000E0C_epilogue\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r6, #6]\n"
        "_sub_08000E0C_epilogue:\n"
        "    pop     {r3}\n"
        "    mov     r8, r3\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_sub_08000E0C_pool_iwram_3720: .4byte gEntities_03003720\n"
        "_sub_08000E0C_pool_iwram_35E0: .4byte gIwram_35E0\n"
        "_sub_08000E0C_pool_coord_a:    .4byte 0x001c0006\n"
        "_sub_08000E0C_pool_coord_b:    .4byte 0x001c0007\n"
        "_sub_08000E0C_pool_coord_c:    .4byte 0x001c000d\n"
        "_sub_08000E0C_pool_coord_d:    .4byte 0x001c000e\n"
        ".syntax divided\n");
}
#endif
