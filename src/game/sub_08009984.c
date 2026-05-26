#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-frame entity classifier / collision dispatch.
 *
 * Reads the current entity's tile-cache pair from gIwram_35E0 and feeds
 * it through two collision-style lookups (sub_0800CD88 / sub_0800CE54),
 * conditioned on the bit-test result of sub_08006BA4. The lookup result
 * (`tile`) drives:
 *   - sub_080204A4(tile) — always called.
 *   - sub_08009884(tile) — called if sub_06BA4 returned the bit-16 mask
 *     (probably "this tile is solid").
 *   - sub_06B88(gIwram_35E0, 0x800)  if tile == 7
 *   - sub_06B88(gIwram_35E0, 0x2000) if tile == 8 || tile == 11
 *
 * Entry-guard: if bit 4 of gIwram_3720._field_34 is set, the function
 * is a no-op. (That bit appears to be a "transition in progress" flag
 * raised by sub_080090B0's caller.)
 *
 * Shipped NAKED. The pure-C body in the NON_MATCHING block plateaued
 * at byte_diff=13 with three instances of the same fifth-class
 * register-coloring drift documented in docs/codegen-notes.md ("Fifth
 * unmatchable class"). All three diffs are `(field & const) != 0`
 * shapes where the baserom emits `movs r0, #const; ldrh/ldrb r1,
 * [base, off]; ands r0, r1` while agbcc emits the load first, AND in
 * the third instance picks a different temporary register (r3 vs r1)
 * because r1 is later reused for the 0x2000 mask. Operand-flip,
 * local-cache, register-pin variations either kept the diff at 13 or
 * regressed; the constant-first ordering and the r3 choice both
 * appear to be unreachable from C input.
 */

extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_080204A4(u8 tile);
extern u32 sub_08006BA4(struct IwramAt35E0 *p, u32 mask);
extern void sub_08009884(u8 tile);
extern u32 sub_0800CE54(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_08006B88(void *p, u16 mask);

#ifdef NON_MATCHING
void sub_08009984(void)
{
    u8 tile;
    u8 tile2;

    if ((gIwram_3720._field_34 & 4) != 0)
        return;

    tile = (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
    sub_080204A4(tile);

    if ((u8)sub_08006BA4(&gIwram_35E0, 16) != 0)
        sub_08009884(tile);

    if ((u8)sub_08006BA4(&gIwram_35E0, 64) != 0) {
        tile2 =
            (u8)sub_0800CE54(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
        if (tile2 == 1)
            gIwram_3720._field_17 = tile2;
        if (tile2 == 2)
            gIwram_3720._field_17 = tile2;
        if (tile2 == 3)
            gIwram_3720._field_17 = tile2;
    }

    if (tile == 7) {
        if ((gIwram_35E0._field_C & 2) != 0)
            goto check8or11;
        if (gIwram_3720._field_1A > 3)
            goto check8or11;
        sub_08006B88(&gIwram_35E0, 0x800);
        return;
    }
check8or11:
    if (tile != 8 && tile != 11)
        return;
    if ((gIwram_35E0._field_C & 2) != 0)
        return;
    if (gIwram_3720._field_1A > 3)
        return;
    sub_08006B88(&gIwram_35E0, 0x2000);
}
#else
NAKED void sub_08009984(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    ldr     r6, _pool_iwram_3720_a\n"
        "    movs    r0, #4\n"
        "    ldrh    r1, [r6, #52]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08009984_epilogue\n"
        "    ldr     r4, _pool_iwram_35E0_a\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r3, #8\n"
        "    ldrsh   r2, [r4, r3]\n"
        "    movs    r5, #10\n"
        "    ldrsh   r3, [r4, r5]\n"
        "    bl      sub_0800CD88\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r5, r0, #24\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_080204A4\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #16\n"
        "    bl      sub_08006BA4\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08009984_skip_9884\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_08009884\n"
        "_sub_08009984_skip_9884:\n"
        "    adds    r0, r4, #0\n"
        "    movs    r1, #64\n"
        "    bl      sub_08006BA4\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08009984_after_ce54\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r7, #8\n"
        "    ldrsh   r2, [r4, r7]\n"
        "    movs    r7, #10\n"
        "    ldrsh   r3, [r4, r7]\n"
        "    bl      sub_0800CE54\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    cmp     r0, #1\n"
        "    bne     _sub_08009984_cmp2\n"
        "    strb    r0, [r6, #23]\n"
        "_sub_08009984_cmp2:\n"
        "    cmp     r0, #2\n"
        "    bne     _sub_08009984_cmp3\n"
        "    strb    r0, [r6, #23]\n"
        "_sub_08009984_cmp3:\n"
        "    cmp     r0, #3\n"
        "    bne     _sub_08009984_after_ce54\n"
        "    strb    r0, [r6, #23]\n"
        "_sub_08009984_after_ce54:\n"
        "    cmp     r5, #7\n"
        "    bne     _sub_08009984_check_8or11\n"
        "    ldr     r2, _pool_iwram_35E0_a\n"
        "    movs    r0, #2\n"
        "    ldrb    r1, [r2, #12]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08009984_check_8or11\n"
        "    ldr     r0, _pool_iwram_3720_a\n"
        "    ldrb    r0, [r0, #26]\n"
        "    cmp     r0, #3\n"
        "    bhi     _sub_08009984_check_8or11\n"
        "    movs    r1, #128\n"
        "    lsls    r1, r1, #4\n"
        "    adds    r0, r2, #0\n"
        "    bl      sub_08006B88\n"
        "    b       _sub_08009984_epilogue\n"
        "    .align  2, 0\n"
        "_pool_iwram_3720_a: .4byte gIwram_3720\n"
        "_pool_iwram_35E0_a: .4byte gIwram_35E0\n"
        "_sub_08009984_check_8or11:\n"
        "    cmp     r5, #8\n"
        "    beq     _sub_08009984_check_gates\n"
        "    cmp     r5, #11\n"
        "    bne     _sub_08009984_epilogue\n"
        "_sub_08009984_check_gates:\n"
        "    ldr     r2, _pool_iwram_35E0_b\n"
        "    movs    r0, #2\n"
        "    ldrb    r3, [r2, #12]\n"
        "    ands    r0, r3\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08009984_epilogue\n"
        "    ldr     r0, _pool_iwram_3720_b\n"
        "    ldrb    r0, [r0, #26]\n"
        "    cmp     r0, #3\n"
        "    bhi     _sub_08009984_epilogue\n"
        "    movs    r1, #128\n"
        "    lsls    r1, r1, #6\n"
        "    adds    r0, r2, #0\n"
        "    bl      sub_08006B88\n"
        "_sub_08009984_epilogue:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_iwram_35E0_b: .4byte gIwram_35E0\n"
        "_pool_iwram_3720_b: .4byte gIwram_3720\n"
        "    .syntax divided\n");
}
#endif
