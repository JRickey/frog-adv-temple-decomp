#include "macros.h"
#include "types.h"

/* Two bit-flag leaves on an entity-record's u16 field at offset 0x2e — the
 * input-flags / "keysJust" field, same offset that mode_15's NAKED case-3
 * code reads as `[r1, #0x2e]`. Both functions were peeled together as one
 * 36-byte slice; the second has no own thumb_func_start in baserom and is
 * given the name sub_08006958 here.
 *
 * This whole TU is built with OLD_AGBCC_BIN (see the Makefile per-TU override):
 * baserom's codegen for this cluster is the older agbcc. The leaf epilogue is
 * the tell — old_agbcc emits a bare `bx lr` with no frame, while newer agbcc
 * wraps a branch-structured multi-return in `push {lr}` / `pop {r1}; bx r1`.
 *
 * sub_08006948: old_agbcc keeps the redundant `adds r1, r2, #0` move that
 * recolours the BIC result into r1 before `strh r1` (newer agbcc coalesces it
 * away to the 2-byte-shorter `strh r2`).
 *
 * sub_08006958: written `mask & field` (not `field & mask`) so the AND lands
 * `and r1, r1, r0` — dest r1, leaving r0 free for the `mov r0, #{0,1}` tail —
 * with the nonzero test first (`if (m & f) return 1; return 0;`) so the branch
 * is `bne` to the return-1 case.
 *
 * sub_0800696C still ships NAKED (see its #ifdef NON_MATCHING block). */

void sub_08006948(u8 *rec, u16 mask)
{
    *(u16 *)(rec + 0x2e) &= ~mask;
}

u8 sub_08006958(u8 *rec, u8 mask)
{
    if (mask & *(u16 *)(rec + 0x2e))
        return 1;
    return 0;
}

/* Sets bit `bits` in the 128-bit flag bank at 0x03006110+20..0x03006110+35.
 *
 * The bank is two 64-bit halves: bits 0..63 land in offsets 20/24 (low/high
 * u32), bits 64..127 land in offsets 28/32. Both halves go through
 * __ashldi3(1, 0, n) — the libgcc 64-bit-left-shift helper at 0x08033ca4.
 *
 * First parameter is ignored — call sites pass 0x03006110 as a base
 * pointer but the function loads it from its own pool. We keep the
 * arg in the C signature so existing two-arg call sites match.
 *
 * Shipped NAKED + NON_MATCHING: agbcc 2.x relentlessly tail-merges the
 * "load bank lo/hi, OR with shift result lo/hi, store back" block from
 * both branches into a single shared tail, even with an explicit early
 * return between them or a separate local-pointer pin per branch (every
 * tested shape — shared u64 *, separate u8 * locals, indexed via base[5/6]
 * with explicit u32 lo/hi splits — produced either the tail-merged form
 * (12 bytes short) or wrong register coloring on the OR direction
 * (orrs r2, r0 instead of orrs r0, r3). Same pattern category as the
 * other documented unmatchable classes: the asm uses different physical
 * registers (r3:r4 for shift result, r0:r1 for loaded bank value) than
 * agbcc's allocator naturally picks. */
NAKED void sub_0800696C(void *unused, s32 bits)
{
    asm(".syntax unified\n"
        "    push    {r4, lr}\n"
        "    adds    r2, r1, #0\n"
        "    cmp     r2, #63\n"
        "    bgt     1f\n"
        "    movs    r0, #1\n"
        "    movs    r1, #0\n"
        "    bl      __ashldi3\n"
        "    adds    r4, r1, #0\n"
        "    adds    r3, r0, #0\n"
        "    ldr     r2, _pool_iwram_6110_a\n"
        "    ldr     r0, [r2, #20]\n"
        "    ldr     r1, [r2, #24]\n"
        "    orrs    r0, r3\n"
        "    orrs    r1, r4\n"
        "    str     r0, [r2, #20]\n"
        "    str     r1, [r2, #24]\n"
        "    b       2f\n"
        "    .align  2, 0\n"
        "_pool_iwram_6110_a: .4byte 0x03006110\n"
        "1:  subs    r2, #64\n"
        "    movs    r0, #1\n"
        "    movs    r1, #0\n"
        "    bl      __ashldi3\n"
        "    adds    r4, r1, #0\n"
        "    adds    r3, r0, #0\n"
        "    ldr     r2, _pool_iwram_6110_b\n"
        "    ldr     r0, [r2, #28]\n"
        "    ldr     r1, [r2, #32]\n"
        "    orrs    r0, r3\n"
        "    orrs    r1, r4\n"
        "    str     r0, [r2, #28]\n"
        "    str     r1, [r2, #32]\n"
        "2:  pop     {r4}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_pool_iwram_6110_b: .4byte 0x03006110\n"
        ".syntax divided\n");
}

#ifdef NON_MATCHING
/* Reference body for the phase-3 PC port. */
void sub_0800696C(void *unused, s32 bits)
{
    unsigned long long mask;
    unsigned long long *bank;

    if (bits > 63) {
        bank = (unsigned long long *)(0x03006110 + 28);
        bits -= 64;
    } else {
        bank = (unsigned long long *)(0x03006110 + 20);
    }
    mask = (unsigned long long)1 << bits;
    *bank |= mask;
}
#endif
