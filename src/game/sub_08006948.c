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
 * sub_0800696C: see the comment on the function itself for its matching shape. */

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
 * Matching shape (avoids agbcc's tail-merge of the two OR-store blocks):
 *   - low case (bits <= 63) is the if-body / fall-through so the test
 *     emits `cmp #63; bgt <high>` like baserom (not the inverted `ble`);
 *   - `mask = 1ULL << bits` is computed BEFORE the base-pointer load in
 *     each branch, so the __ashldi3 result is moved out of r0:r1 and the
 *     bank is reloaded into r0:r1 — giving `orrs r0, r3 / orrs r1, r4`;
 *   - the base ptr is reloaded per branch from `0x03006110` (a fresh local
 *     each branch) and indexed via `(char *)bank + 20/28`, keeping the
 *     offset in the load (`ldr [r2, #20]`) instead of folding it into the
 *     pool literal — which is what makes agbcc emit two independent blocks;
 *   - `register ... asm("r2")` pins the base into r2 (the slot `bits`
 *     vacates) so the shift result colours into r3:r4, matching baserom. */
void sub_0800696C(void *unused, s32 bits)
{
    unsigned long long mask;
    register unsigned long long *bank asm("r2");

    if (bits <= 63) {
        mask = (unsigned long long)1 << bits;
        bank = (unsigned long long *)0x03006110;
        *(unsigned long long *)((char *)bank + 20) |= mask;
        return;
    }

    bits -= 64;
    mask = (unsigned long long)1 << bits;
    bank = (unsigned long long *)0x03006110;
    *(unsigned long long *)((char *)bank + 28) |= mask;
}
