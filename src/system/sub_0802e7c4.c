#include "sound.h"
#include "macros.h"

/* sub_0802E7C4 — per-channel pan apply.
 *
 * Sister to sub_0802E724 (per-channel silence/reset). Same SoundSystem
 * fields; the new ones here are:
 *   +0xBA (u8 panBits) — cached high byte of REG_SOUNDCNT_L (channel
 *                       L/R enable bitmap). Bit ch enables right (SO1),
 *                       bit ch+4 enables left (SO2).
 *   +0x010F (u8 muteMask) — per-channel mute byte; if bit 0x10 is set the
 *                       channel is muted and pan updates collapse to "redo
 *                       the same bits" — clear+set the same {ch, ch+4} pair,
 *                       which is a no-op in panBits but still re-emits the
 *                       cached byte to REG_SOUNDCNT_L.
 *
 * sub_0802E7C4(pan, ch): apply pan position `pan` (0..127, plus 0xFF =
 *   leave muted) to channel ch.
 *     ch in 0..3: clear bits {ch, ch+4} from panBits, then OR in:
 *       pan <= 41          → 0x10<<ch (left only)
 *       42 <= pan <= 85    → 0x11<<ch (centre — both)
 *       86 <= pan <= 254   → 0x01<<ch (right only)
 *       pan == 0xFF or muted → 0x11<<ch (no-op: same bits we cleared)
 *     and write REG_SOUNDCNT_L hi byte = panBits.
 *     ch >= 4: write pan into swSlots[ch-4]+0x3c. If it changed, set
 *     slot.flags bit 0x80 (mixer reapplies on next tick).
 *
 * Companion sub_0802E874 (delta-pan, externally called from 0x08031148)
 * stays in asm/disasm_0x0802e874.s — its small-channel path needs old_agbcc
 * to spill ss into a caller-save scratch (r1) while keeping ch in r3, and
 * agbcc 2.x's natural choice is to put ss in r4 (callee-save). Decomp
 * deferred until that idiom can be matched.
 */

#define REG_SOUNDCNT_L (*(vu16 *)0x04000080)

/* Matching notes:
 *   - `(0x88 << 21) << ch >> 24` reproduces the baserom's three-shift
 *     channel-bitmap derivation. `0x88 << 21 == 0x11000000` and the final
 *     `>>24` extracts the byte (bits ch and ch+4 set). Writing `0x11 << ch`
 *     directly would let agbcc skip the first shift and break the match.
 *   - The `pPool / gpsp` split forces old_agbcc to materialise the pool
 *     pointer (`&gpSoundSystem` → r2) before saving a copy into r7. Folding
 *     them into one variable lets agbcc skip the `adds r7, r2, #0` and
 *     instead reload via the original pool literal.
 *   - `maskTen = 0x10 & muteByte; if (maskTen != 0)` is a deliberate
 *     workaround: writing the natural `if ((muteByte & 0x10) != 0)` emits
 *     `adds r7, r2, #0` BEFORE the `ands`, which doesn't match. Splitting
 *     the AND into a stored value pushes the r7 spill past the AND.
 *   - The mute-or-0xFF paths fall through to `orr_phase` with `mask` still
 *     holding `0x11<<ch` (the original clear mask), so the |= is a no-op
 *     on panBits but the REG_SOUNDCNT_L write still happens.
 *   - Compiled with old_agbcc (see Makefile per-file override) — natural
 *     agbcc 2.x folds the chBit `>> 24` into the prior `<< 21`, breaking
 *     the `lsrs r3, r0, #24` post-shift.
 */

void sub_0802E7C4(u8 pan, s32 ch)
{
    SoundSystem **pPool;
    SoundSystem **gpsp;
    u32 mask;
    u32 maskTen;
    u8 muteByte;

    if (ch > 3)
        goto big_slot;

    mask = (0x88u << 21) << ch >> 24;
    pPool = &gpSoundSystem;
    (*pPool)->panBits &= ~mask;
    muteByte = *((u8 *)*pPool + 0x010f);
    maskTen = 0x10 & muteByte;
    gpsp = pPool;
    if (maskTen != 0)
        goto orr_phase;
    maskTen = 0x10;
    if (pan == 0xff)
        goto orr_phase;
    if (pan <= 0x29) {
        mask = (maskTen << ch) << 24 >> 24;
        goto orr_phase;
    }
    if (pan > 0x55) {
        mask = (0x80u << 17) << ch >> 24;
    }
    /* else: mask stays 0x11<<ch (centre — both bits) */
orr_phase:
    (*gpsp)->panBits |= mask;
    REG_SOUNDCNT_L = (REG_SOUNDCNT_L & 0xff) | ((*gpsp)->panBits << 8);
    return;

big_slot: {
    SoundSlot *slot;
    u8 oldPan;

    slot = (SoundSlot *)((u8 *)gpSoundSystem->swSlots + (ch * 64 - 256));
    oldPan = *((u8 *)slot + 0x3c);
    *((u8 *)slot + 0x3c) = pan;
    if (pan == oldPan)
        return;
    slot->flags |= 0x80;
}
}

/* sub_0802E874 — delta-pan applicator. Externally called from 0x08031148.
 *
 * Takes a signed delta in the s8 range and applies it to channel `ch`:
 *   ch in 0..3 (small slot): decode current pan-bits {ch, ch+4} back to
 *     a 0..127 position (0x10 → 42, 0x01 → 85, otherwise → 64), add the
 *     delta, clamp [0..127], then forward to sub_0802E7C4 to re-emit.
 *     If the channel is muted (muteMask bit 0x10), skip the decode and
 *     reapply at centre (64).
 *   ch >= 4 (big slot): read swSlots[ch-4].pan, abort if 0xff, otherwise
 *     add delta, clamp, write back, set the dirty bit.
 *
 * Shipped NAKED + #ifdef NON_MATCHING — 5th-class register-coloring drift.
 * Baserom keeps the gpSoundSystem deref in r1 (caller-save scratch) across
 * the muteByte read and the panBits read; agbcc 2.x's natural allocator
 * picks r2 (or r4 callee-save depending on surrounding code), and the
 * 1-register shift cascades through every subsequent instruction (147
 * byte diff). Permuter ran 3300+ iter with no candidate beating the
 * baseline byte_diff. Documented as the same class as sub_08006B94 /
 * sub_080090B0 — agbcc can't be coerced into the baserom's allocation
 * by any source-level rearrangement.
 *
 * Reference C body below (NON_MATCHING side) mirrors sister sub_0802E7C4
 * tricks: `pPool/gpsp` split, `(0x88u << 21) << ch >> 24` for chBit kept
 * as s32 so `>> ch` lowers to `asrs`, and two-copy delta handling (signed
 * for the early cmp, u8 preserved for late re-derivation after r4 gets
 * reused as chBit).
 */

#ifdef NON_MATCHING
void sub_0802E874(s8 delta, s32 ch)
{
    SoundSystem **pPool;
    SoundSystem **gpsp;
    s32 newPan;
    s32 chBit;
    u32 maskTen;
    u8 muteByte;
    u8 deltaU;
    u32 extracted;

    deltaU = (u8)delta;
    if (delta == 0)
        return;

    if (ch > 3)
        goto big_slot;

    chBit = (s32)((0x88u << 21) << ch >> 24);
    pPool = &gpSoundSystem;
    muteByte = *((u8 *)*pPool + 0x010f);
    maskTen = 0x10 & muteByte;
    gpsp = pPool;
    if (maskTen != 0) {
        newPan = 0x40;
        goto call_pan;
    }

    extracted = ((u32)(((s32)(*gpsp)->panBits & chBit) >> ch)) & 0xff;

    newPan = 0x2a;
    if (extracted != 0x10) {
        newPan = 0x40;
        if (extracted == 1)
            newPan = 0x55;
    }
    newPan += (s8)deltaU;
    if (newPan < 0) {
        newPan = 0;
        goto call_pan;
    }
    if (newPan > 0x7f)
        newPan = 0x7f;

call_pan:
    sub_0802E7C4((u8)newPan, ch);
    return;

big_slot: {
    SoundSlot *slot;
    s32 newPanB;
    u8 oldPan;

    slot = (SoundSlot *)((u8 *)gpSoundSystem->swSlots + (ch * 64 - 256));
    oldPan = *((u8 *)slot + 0x3c);
    if (oldPan == 0xff)
        return;
    newPanB = oldPan + delta;
    if (newPanB < 0)
        newPanB = 0;
    else if (newPanB > 0x7f)
        newPanB = 0x7f;
    *((u8 *)slot + 0x3c) = (u8)newPanB;
    slot->flags |= 0x80;
}
}
#else
NAKED
void sub_0802E874(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    adds    r3, r1, #0\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r5, r0, #24\n"
        "    asrs    r4, r0, #24\n"
        "    cmp     r4, #0\n"
        "    beq     _0802E92C\n"
        "    cmp     r3, #3\n"
        "    bgt     _0802E8EA\n"
        "    movs    r0, #0x88\n"
        "    lsls    r0, r0, #21\n"
        "    lsls    r0, r3\n"
        "    lsrs    r4, r0, #24\n"
        "    ldr     r0, _0802E8CC\n"
        "    ldr     r1, [r0, #0]\n"
        "    ldr     r0, _0802E8D0\n"
        "    adds    r2, r1, r0\n"
        "    movs    r0, #0x10\n"
        "    ldrb    r2, [r2, #0]\n"
        "    ands    r0, r2\n"
        "    cmp     r0, #0\n"
        "    bne     _0802E8DC\n"
        "    adds    r1, #0xba\n"
        "    adds    r0, r4, #0\n"
        "    ldrb    r1, [r1, #0]\n"
        "    ands    r0, r1\n"
        "    asrs    r0, r3\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    movs    r1, #0x2a\n"
        "    cmp     r0, #0x10\n"
        "    beq     _0802E8BC\n"
        "    movs    r1, #0x40\n"
        "    cmp     r0, #1\n"
        "    bne     _0802E8BC\n"
        "    movs    r1, #0x55\n"
        "_0802E8BC:\n"
        "    lsls    r0, r5, #24\n"
        "    asrs    r0, r0, #24\n"
        "    adds    r1, r1, r0\n"
        "    cmp     r1, #0\n"
        "    bge     _0802E8D4\n"
        "    movs    r1, #0\n"
        "    b       _0802E8DE\n"
        "    .align  2, 0\n"
        "_0802E8CC: .word 0x030065e0\n"
        "_0802E8D0: .word 0x0000010f\n"
        "_0802E8D4:\n"
        "    cmp     r1, #0x7f\n"
        "    ble     _0802E8DE\n"
        "    movs    r1, #0x7f\n"
        "    b       _0802E8DE\n"
        "_0802E8DC:\n"
        "    movs    r1, #0x40\n"
        "_0802E8DE:\n"
        "    lsls    r0, r1, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    adds    r1, r3, #0\n"
        "    bl      sub_0802E7C4\n"
        "    b       _0802E92C\n"
        "_0802E8EA:\n"
        "    ldr     r0, _0802E910\n"
        "    ldr     r1, [r0, #0]\n"
        "    adds    r1, #0xc8\n"
        "    lsls    r0, r3, #6\n"
        "    ldr     r2, _0802E914\n"
        "    adds    r0, r0, r2\n"
        "    ldr     r1, [r1, #0]\n"
        "    adds    r2, r1, r0\n"
        "    adds    r1, r2, #0\n"
        "    adds    r1, #0x3c\n"
        "    ldrb    r0, [r1, #0]\n"
        "    cmp     r0, #0xff\n"
        "    beq     _0802E92C\n"
        "    ldrb    r1, [r1, #0]\n"
        "    adds    r1, r1, r4\n"
        "    cmp     r1, #0\n"
        "    bge     _0802E918\n"
        "    movs    r1, #0\n"
        "    b       _0802E91E\n"
        "    .align  2, 0\n"
        "_0802E910: .word 0x030065e0\n"
        "_0802E914: .word 0xffffff00\n"
        "_0802E918:\n"
        "    cmp     r1, #0x7f\n"
        "    ble     _0802E91E\n"
        "    movs    r1, #0x7f\n"
        "_0802E91E:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0x3c\n"
        "    strb    r1, [r0, #0]\n"
        "    ldr     r0, [r2, #0x38]\n"
        "    movs    r1, #0x80\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r2, #0x38]\n"
        "_0802E92C:\n"
        "    pop     {r4, r5}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
