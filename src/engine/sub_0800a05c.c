#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-frame software reset of the OBJ / OAM-shadow / hit-log / entity-table
 * banks. Sits at the tail of the low-ROM dispatch cluster (after sub_08009D9C
 * and sub_0800A328). The body has six sequential stages, three of which are
 * CpuFastSet calls through the sub_0802D558 wrapper:
 *
 *   1. CpuFastSet-fill 32 bytes (8 words) of OBJ-tile VRAM at 0x06010000 with
 *      a zeroed scratch word on the stack.
 *   2. Walk the 64-entry OAM shadow at 0x030054a0 (stride 8, span +0x3f8):
 *      first halfword := 0xf0 (off-screen Y), next two halfwords := 0.
 *   3. CpuFastSet-copy the cleared OAM shadow (0x030054a0) into OAM
 *      (0x07000000), 0x100 words.
 *   4. Clear the 64-slot hit log at 0x03006160 (stride 8): halfword at +2 and
 *      byte at +0 := 0.
 *   5. CpuFastSet-fill the entity table at 0x03003720 with 0 (0x700 words).
 *   6. Walk the entity table (stride 0x38, 128 entries) and set bit 3 of each
 *      entity's +0x34 status halfword.
 *
 * Shipped NAKED. The baserom spills the &scratch[1] stack pointer into the
 * Thumb high register r8 (`add r0, sp, #4; mov r8, r0`) and re-emits it into
 * r0 as the CpuFastSet src for stage 5 (`mov r0, r8`). Per
 * docs/codegen-notes.md "High registers (sl/r10, sb/r9, r8, ip/r12) —
 * corpus-validated unmatchable", agbcc 2.x will not promote a value into r8
 * from C input, so the high-register exception in the NAKED gate applies — no
 * permuter required. The NON_MATCHING reference body below documents intent
 * for the phase-3 PC port.
 */

extern void sub_0802D558(void *dst, void *src, u32 count);

#ifdef NON_MATCHING
void sub_0800A05C(void)
{
    u32 scratch[2];
    u16 *oam;
    u8 *hit;
    u8 *ent;
    s32 i;
    s32 j;

    scratch[0] = 0;
    sub_0802D558((void *)0x06010000, &scratch[0], 0x01000008);

    oam = (u16 *)0x030054a0;
    for (i = 0; i <= 0x3f; i++) {
        oam[0] = 0xf0;
        oam[1] = 0;
        oam[2] = 0;
        oam[3] = 0;
        oam += 4;
    }

    sub_0802D558((void *)0x07000000, (void *)0x030054a0, 0x100);

    hit = (u8 *)0x03006160;
    for (i = 0; i <= 0x3f; i++) {
        *(u16 *)(hit + 2) = 0;
        hit[0] = 0;
        hit += 8;
    }

    scratch[1] = 0;
    sub_0802D558((void *)0x03003720, &scratch[1], 0x01000700);

    ent = (u8 *)(0x03003720 + 0x34);
    for (j = 0x7f; j >= 0; j--) {
        *(u16 *)ent |= 8;
        ent += 0x38;
    }
}
#else
NAKED void sub_0800A05C(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, r8\n"
        "    push    {r7}\n"
        "    sub     sp, #8\n"
        "    movs    r0, #0\n"
        "    str     r0, [sp, #0]\n"
        "    ldr     r1, _sub_0800A05C_pool_obj_vram\n"
        "    ldr     r2, _sub_0800A05C_pool_fill_8\n"
        "    mov     r0, sp\n"
        "    bl      sub_0802D558\n"
        "    add     r0, sp, #4\n"
        "    mov     r8, r0\n"
        "    ldr     r0, _sub_0800A05C_pool_oam_shadow\n"
        "    movs    r5, #0\n"
        "    adds    r3, r0, #0\n"
        "    movs    r1, #254\n"
        "    lsls    r1, r1, #2\n"
        "    adds    r7, r0, r1\n"
        "    movs    r6, #240\n"
        "    adds    r4, r0, #0\n"
        "_sub_0800A05C_oam_loop:\n"
        "    strh    r6, [r3, #0]\n"
        "    adds    r1, r4, #2\n"
        "    movs    r2, #2\n"
        "_sub_0800A05C_oam_inner:\n"
        "    strh    r5, [r1, #0]\n"
        "    adds    r1, #2\n"
        "    subs    r2, #1\n"
        "    cmp     r2, #0\n"
        "    bge     _sub_0800A05C_oam_inner\n"
        "    adds    r3, #8\n"
        "    adds    r4, #8\n"
        "    cmp     r3, r7\n"
        "    ble     _sub_0800A05C_oam_loop\n"
        "    movs    r1, #224\n"
        "    lsls    r1, r1, #19\n"
        "    movs    r2, #128\n"
        "    lsls    r2, r2, #1\n"
        "    bl      sub_0802D558\n"
        "    movs    r5, #0\n"
        "    movs    r1, #0\n"
        "    ldr     r0, _sub_0800A05C_pool_hit_log\n"
        "_sub_0800A05C_hit_loop:\n"
        "    strh    r1, [r0, #2]\n"
        "    strb    r5, [r0, #0]\n"
        "    adds    r0, #8\n"
        "    adds    r5, #1\n"
        "    cmp     r5, #63\n"
        "    ble     _sub_0800A05C_hit_loop\n"
        "    movs    r0, #0\n"
        "    str     r0, [sp, #4]\n"
        "    ldr     r4, _sub_0800A05C_pool_entity\n"
        "    ldr     r2, _sub_0800A05C_pool_fill_700\n"
        "    mov     r0, r8\n"
        "    adds    r1, r4, #0\n"
        "    bl      sub_0802D558\n"
        "    movs    r1, #8\n"
        "    adds    r4, #52\n"
        "    movs    r5, #127\n"
        "_sub_0800A05C_ent_loop:\n"
        "    ldrh    r0, [r4, #0]\n"
        "    orrs    r0, r1\n"
        "    strh    r0, [r4, #0]\n"
        "    adds    r4, #56\n"
        "    subs    r5, #1\n"
        "    cmp     r5, #0\n"
        "    bge     _sub_0800A05C_ent_loop\n"
        "    add     sp, #8\n"
        "    pop     {r3}\n"
        "    mov     r8, r3\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_sub_0800A05C_pool_obj_vram:   .4byte 0x06010000\n"
        "_sub_0800A05C_pool_fill_8:     .4byte 0x01000008\n"
        "_sub_0800A05C_pool_oam_shadow: .4byte 0x030054a0\n"
        "_sub_0800A05C_pool_hit_log:    .4byte 0x03006160\n"
        "_sub_0800A05C_pool_entity:     .4byte 0x03003720\n"
        "_sub_0800A05C_pool_fill_700:   .4byte 0x01000700\n"
        "    .syntax divided\n");
}
#endif
