#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-entity probe / tile-collision dispatch helper.
 *
 * Called with (entity_ptr, arg1) from the AgbMain dispatch cluster
 * (sits between sub_08000918 — mode 8 — and sub_08000C98). The
 * function:
 *
 *   1. Calls sub_0800B918(ent, arg1, 18) — enqueue with kind=18.
 *   2. If gIwram_3720._field_34 has bit 4 set, returns immediately
 *      (the mode is already locked).
 *   3. Probes the tile under the current entity by calling
 *      sub_0800CD88(col, row, tileX, tileY) reading the cache at
 *      gIwram_35E0 (+0x18, +0x19, +0x8, +0xA). Result narrowed to u8.
 *   4. If gIwram_35E0._field_10 has bit 0x10 set, also calls
 *      sub_0800B8A8(ent, arg1, 18, tile) — kind+tile follow-up.
 *   5. If gIwram_35E0._field_10 has bit 0x40 set AND sub_0800CDCC(...)
 *      returns nonzero as u8, toggles a two-slot state pair:
 *        - first-time   (gIwram_35E0._field_18 == 0):
 *            _field_18=1, _field_19=1, gIwram_3720[+6]=2,
 *            gIwram_3720._field_17=2
 *        - second-time  (gIwram_35E0._field_18 != 0):
 *            _field_18=0, _field_19=0, gIwram_3720[+6]=3,
 *            gIwram_3720._field_17=3
 *   6. If gGameStuff._unk10 has bit 1 set, returns.
 *   7. Counter gates on gIwram_3720._field_2 against the bands {408,
 *      0xaa..0xaa+24, 0xfefc..0xfefc+24}, raising bit 0x800 (via
 *      sub_08006B88) or clearing bit 2 (via sub_08006B94) at
 *      gIwram_35E0._field_10 accordingly, and ±1-stepping the counter.
 *
 * Shipped NAKED. The baserom uses Thumb high registers extensively:
 *   - `mov sl, r1` — arg1 spilled into sl for one cross-block reuse
 *     (forwarded into sub_0800B8A8 as arg2 after sub_0800CD88 returns).
 *   - `mov r8, r0` then `mov r1, r8` / `mov r7, r8` — pool literal
 *     0x03003720 (= &gIwram_3720) cached in r8 and re-emitted into
 *     low regs as needed.
 *   - `mov r9, r0` then `mov r3, r9` — the (u8)tile result of
 *     sub_0800CD88 spilled into r9 to survive sub_0800B8A8 and the
 *     second half of the function.
 *
 * Three independent high-register pins. Per docs/codegen-notes.md
 * "High registers (sl/r10, sb/r9, r8, ip/r12) — corpus-validated
 * unmatchable", agbcc 2.x will not promote any of these values into
 * a high register from C input. The high-register exception in the
 * NAKED gate (tools/agent/prompts/decomp.md) applies — no permuter
 * required.
 *
 * Variants considered before NAKED:
 *   1. Pure C with all temporaries low — baserom still spills sl
 *      (arg1 used after sub_0800CD88 call) and r8 (gIwram_3720
 *      reused after sub_0800CD88 call); no C input reaches a `mov sl, _`
 *      or `mov r8, _`.
 *   2. Entry pin of `arg1_hi` to sl —
 *      ignored by agbcc for high regs (corpus-validated; only r4-r7
 *      respected, per the fixed-register local note in codegen-notes).
 *   3. Local-pointer-shadow `IwramAt3720 *gp = &gIwram_3720;` —
 *      anchors the address load early but agbcc keeps it in r4/r5,
 *      not r8.
 *   4. Splitting the gIwram_3720-+6 / +0x17 writes into a static
 *      helper so the value doesn't survive across blocks — restructures
 *      control flow with an extra `bl`, breaking the baserom's
 *      inline tail.
 *   5. Caching (u8)tile in a low-register local pinned to r5
 *      (the r5-pinned `tile` local) — works for the pin, but
 *      surrounding registers re-allocate around r5 in ways that
 *      shift sub_0800B8A8's arg-marshalling and reposition the
 *      inline pool literals at 0xbf8/0xbfc.
 *
 * NON_MATCHING reference body below for the phase-3 PC port.
 */

extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern u32 sub_0800CDCC(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_08006B88(void *p, u16 mask);
extern void sub_08006B94(void *p, u16 mask);

#ifdef NON_MATCHING
void sub_08000B6C(void *ent, u32 arg1)
{
    u8 *gp3720 = (u8 *)&gIwram_3720;
    u8 tile;
    u16 ctr;

    sub_0800B918(ent, arg1, 18);

    if ((gIwram_3720._field_34 & 4) != 0)
        return;

    tile = (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);

    if ((gIwram_35E0._field_10 & 0x10) != 0)
        sub_0800B8A8(ent, arg1, 18, tile);

    if ((gIwram_35E0._field_10 & 0x40) != 0) {
        if ((u8)sub_0800CDCC(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                             gIwram_35E0._field_A) != 0) {
            if (gIwram_35E0._field_18 == 0) {
                gIwram_35E0._field_18 = 1;
                gIwram_35E0._field_19 = 1;
                gp3720[6] = 2;
                gIwram_3720._field_17 = 2;
            } else {
                gIwram_35E0._field_18 = 0;
                gIwram_35E0._field_19 = 0;
                gp3720[6] = 3;
                gIwram_3720._field_17 = 3;
            }
        }
    }

    if ((*(u8 *)((u8 *)&gGameStuff + 0x10) & 1) != 0)
        return;

    if (gIwram_3720._field_2 > 408) {
        sub_08006B88(&gIwram_35E0, 0x800);
    }

    if (tile != 7)
        return;

    if ((s16)gIwram_3720._field_4 > 1000) {
        ctr = gIwram_3720._field_2;
        if ((u16)(ctr - 0xaa) <= 24) {
            sub_08006B94(&gIwram_35E0, 2);
            gIwram_3720._field_2 = ctr - 1;
        }
    }

    ctr = gIwram_3720._field_2;
    if ((u16)(ctr + 0xfefc) <= 24) {
        sub_08006B94(&gIwram_35E0, 2);
        gIwram_3720._field_2 = ctr + 1;
    }
}
#else
NAKED void sub_08000B6C(void *ent, u32 arg1)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    adds    r6, r0, #0\n"
        "    mov     sl, r1\n"
        "    movs    r2, #18\n"
        "    bl      sub_0800B918\n"
        "    ldr     r0, _sub_08000B6C_pool_iwram_3720_a\n"
        "    mov     r8, r0\n"
        "    movs    r0, #4\n"
        "    mov     r1, r8\n"
        "    ldrh    r1, [r1, #52]\n"
        "    ands    r0, r1\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r5, r0, #16\n"
        "    cmp     r5, #0\n"
        "    bne     _sub_08000B6C_epilogue\n"
        "    ldr     r4, _sub_08000B6C_pool_iwram_35E0_a\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r3, #8\n"
        "    ldrsh   r2, [r4, r3]\n"
        "    movs    r7, #10\n"
        "    ldrsh   r3, [r4, r7]\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    mov     r9, r0\n"
        "    movs    r0, #16\n"
        "    ldrh    r1, [r4, #16]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000B6C_after_b8a8\n"
        "    adds    r0, r6, #0\n"
        "    mov     r1, sl\n"
        "    movs    r2, #18\n"
        "    mov     r3, r9\n"
        "    bl      sub_0800B8A8\n"
        "_sub_08000B6C_after_b8a8:\n"
        "    movs    r0, #64\n"
        "    ldrh    r2, [r4, #16]\n"
        "    ands    r0, r2\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000B6C_after_gate\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r3, #8\n"
        "    ldrsh   r2, [r4, r3]\n"
        "    movs    r6, #10\n"
        "    ldrsh   r3, [r4, r6]\n"
        "    bl      sub_0800CDCC\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000B6C_after_gate\n"
        "    ldrb    r0, [r4, #24]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000B6C_branchB\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r4, #24]\n"
        "    strb    r0, [r4, #25]\n"
        "    movs    r0, #2\n"
        "    mov     r7, r8\n"
        "    strb    r0, [r7, #6]\n"
        "    strb    r0, [r7, #23]\n"
        "    b       _sub_08000B6C_after_gate\n"
        "    .align  2, 0\n"
        "_sub_08000B6C_pool_iwram_3720_a: .4byte gIwram_3720\n"
        "_sub_08000B6C_pool_iwram_35E0_a: .4byte gIwram_35E0\n"
        "_sub_08000B6C_branchB:\n"
        "    strb    r5, [r4, #24]\n"
        "    strb    r5, [r4, #25]\n"
        "    movs    r0, #3\n"
        "    mov     r1, r8\n"
        "    strb    r0, [r1, #6]\n"
        "    strb    r0, [r1, #23]\n"
        "_sub_08000B6C_after_gate:\n"
        "    ldr     r1, _sub_08000B6C_pool_gGameStuff\n"
        "    movs    r0, #1\n"
        "    ldrb    r1, [r1, #16]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000B6C_epilogue\n"
        "    ldr     r4, _sub_08000B6C_pool_iwram_3720_b\n"
        "    movs    r0, #204\n"
        "    lsls    r0, r0, #1\n"
        "    ldrh    r2, [r4, #2]\n"
        "    cmp     r2, r0\n"
        "    bls     _sub_08000B6C_skip_b88\n"
        "    ldr     r0, _sub_08000B6C_pool_iwram_35E0_b\n"
        "    movs    r1, #128\n"
        "    lsls    r1, r1, #4\n"
        "    bl      sub_08006B88\n"
        "_sub_08000B6C_skip_b88:\n"
        "    mov     r3, r9\n"
        "    cmp     r3, #7\n"
        "    bne     _sub_08000B6C_epilogue\n"
        "    movs    r6, #4\n"
        "    ldrsh   r1, [r4, r6]\n"
        "    movs    r0, #250\n"
        "    lsls    r0, r0, #2\n"
        "    cmp     r1, r0\n"
        "    ble     _sub_08000B6C_check_tail\n"
        "    ldrh    r0, [r4, #2]\n"
        "    subs    r0, #170\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #24\n"
        "    bhi     _sub_08000B6C_check_tail\n"
        "    ldr     r0, _sub_08000B6C_pool_iwram_35E0_b\n"
        "    movs    r1, #2\n"
        "    bl      sub_08006B94\n"
        "    ldrh    r0, [r4, #2]\n"
        "    subs    r0, #1\n"
        "    strh    r0, [r4, #2]\n"
        "_sub_08000B6C_check_tail:\n"
        "    ldr     r4, _sub_08000B6C_pool_iwram_3720_b\n"
        "    ldrh    r7, [r4, #2]\n"
        "    ldr     r1, _sub_08000B6C_pool_neg_0x104\n"
        "    adds    r0, r7, r1\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #24\n"
        "    bhi     _sub_08000B6C_epilogue\n"
        "    ldr     r0, _sub_08000B6C_pool_iwram_35E0_b\n"
        "    movs    r1, #2\n"
        "    bl      sub_08006B94\n"
        "    ldrh    r0, [r4, #2]\n"
        "    adds    r0, #1\n"
        "    strh    r0, [r4, #2]\n"
        "_sub_08000B6C_epilogue:\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    movs    r0, r0\n"
        "_sub_08000B6C_pool_gGameStuff:    .4byte 0x03005330\n"
        "_sub_08000B6C_pool_iwram_3720_b:  .4byte gIwram_3720\n"
        "_sub_08000B6C_pool_iwram_35E0_b:  .4byte gIwram_35E0\n"
        "_sub_08000B6C_pool_neg_0x104:     .4byte 0xfffffefc\n"
        ".syntax divided\n");
}
#endif
