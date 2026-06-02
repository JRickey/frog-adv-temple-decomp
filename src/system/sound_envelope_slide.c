#include "sound.h"
#include "macros.h"

/* sub_0802F054 — per-frame multi-mode envelope tick (envelope-C).
 *
 * Largest of the per-frame envelope ticks in the sound cluster. Sister to
 * sub_0802EC7C (sound_channel.c, envelope-A at +0x1c), sub_0802ED5C
 * (sound_channel.c, envelope-B at +0x2c), sub_0802EA80 (sound_envelope.c,
 * envelope-A0 at +0x14), sub_0802E934 (sound_envelope_dual.c, dual at +4/+12),
 * sub_0802F2FC (sound_pan.c, pan envelope at +0x0a/+0x12). This one drives
 * a mode-dispatched envelope block at +0x24/+0x28 inside each
 * channel/slot — referred to in the codebase notes as "envelope-C".
 *
 * The dispatcher consults `flags & 6` (two bits of mode at bits 1-2) on each
 * iteration and picks one of four behaviours:
 *
 *   mode 0 — slide-up:    sum = acc + cfg->w0; if sum > 0xfeff, clamp at
 *                          0xff00 and set mode := 1 (bits 1-2 = 01).
 *   mode 1 — slide-down:  sum = acc - cfg->w2; if sum > cfg->w4, write sum;
 *                          else clamp at cfg->w4 and set mode := 2 (bits
 *                          1-2 = 10).
 *   mode 2 — kickoff:     if flags & 0x10, set bits 1-2 := 3 (= "stop"
 *                          phase) and fall through to mode 3.
 *   mode 3 — converge:    diff = (s32)w_acc - cfg->w6; if diff > 0xff, write
 *                          diff; else clear bits 0-2 of flags and pin acc
 *                          at 0.
 *
 * After each branch the channel-level acc and the upper-byte tracker
 * (acc & 0xff00 vs prev_acc & 0xff00) decide whether the channel-flags
 * dirty bit 0x80 is OR'd in: any upper-byte change marks the channel
 * dirty so the mixer reapplies the envelope value on the next mix step.
 *
 * Stage 1 (4 iterations, fixed): four inline channel envelope blocks
 * embedded in SoundSystem itself at ss+0x8c, ss+0x94, ss+0x9c, ss+0xa4
 * (stride 8). Walked i=3 down to 0 (loop counter in r8, decremented to
 * -1). Mode dispatch only fires if chFlags[i] & 1 is set; otherwise
 * the inactive slide path runs if chFlags[i] & 0x20 is set, advancing
 * the accumulator until it clamps and clears bit 0x20.
 *
 * Stage 2 (ss->count iterations): per-slot envelope-C bank, walked via
 * ss->slotPtrTable[i] with the same mode dispatch over slot->flags
 * (+0x38), acc at slot+0x28, cfg-pointer at slot+0x24.
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. The baserom
 * pins multiple values into Thumb high registers as loop state:
 *   sl  =  0xf000                  (upper-byte mask, also fold-resistant)
 *   r9  =  channel-block offset (0x8c + i*8 stage 1; 0xffffffe1 stage 2)
 *   r8  =  outer loop counter      (stage 1 down from 3; stage 2 up to count)
 *   ip  =  chFlags byte offset     (i*4)
 * agbcc 2.x will not promote any of these to high regs from C source —
 * see docs/codegen-notes.md "High registers (sl/r10, sb/r9, r8) —
 * corpus-validated unmatchable". The readable C is preserved behind
 * NON_MATCHING for the phase-3 PC port; the NAKED form ships the
 * baserom bytes.
 */

/* Per-mode configuration block referenced by ch_block->cfg. Halfwords
 * laid out so the dispatch can index them by mode. */
#ifdef NON_MATCHING
static void envelope_c_tick(EnvelopeCBlock *blk, u32 *pFlags, u32 chFlagWord, u32 dirtyBit);
static void envelope_c_inactive_tick(EnvelopeCBlock *blk, u32 *pFlags, u32 flags, u32 dirtyBit);

void sub_0802F054(void)
{
    SoundSystem *ss;
    SoundSlot *slot;
    s32 i;
    u32 flags;
    u32 *pFlags;
    EnvelopeCBlock *blk;

    /* Stage 1: 4 inline channel envelope blocks at ss+0x8c, +0x94, +0x9c,
     * +0xa4 (stride 8). Loop counter walks down 3 -> 0. */
    for (i = 3; i >= 0; i--) {
        ss = gpSoundSystem;
        pFlags = &ss->chFlags[i];
        flags = *pFlags;
        if (flags & 1) {
            blk = &((EnvelopeCBlock *)((u8 *)ss + 0x8c))[3 - i];
            envelope_c_tick(blk, pFlags, flags, 0x80);
        } else if (flags & 0x20) {
            blk = &((EnvelopeCBlock *)((u8 *)ss + 0x8c))[3 - i];
            envelope_c_inactive_tick(blk, pFlags, flags, 0x80);
        }
    }

    /* Stage 2: per-slot envelope-C, walked via slotPtrTable[0..count). */
    for (i = 0; i < gpSoundSystem->count; i++) {
        slot = gpSoundSystem->slotPtrTable[i];
        if (slot == NULL)
            continue;
        flags = slot->flags;
        if (flags & 1) {
            envelope_c_tick(&slot->envelopeC, &slot->flags, flags, 0x80);
        } else if (flags & 0x20) {
            envelope_c_inactive_tick(&slot->envelopeC, &slot->flags, flags, 0x80);
        }
    }
}

/* Shared mode dispatcher for stage 1 / stage 2. The baserom inlines this
 * twice (once per stage) but the structure is identical. */
static void envelope_c_tick(EnvelopeCBlock *blk, u32 *pFlags, u32 flags, u32 dirtyBit)
{
    u16 acc = blk->acc;
    u16 prevAcc = acc;
    s32 sum;
    EnvelopeCConfig *cfg = blk->cfg;
    s32 mode = (flags >> 1) & 3;

    switch (mode) {
    case 0: /* slide-up */
        sum = (s32)cfg->w0 + (s32)acc;
        if (sum > 0xfeff) {
            *pFlags = (flags & (u32)-7) | 2u;
            sum = 0xff00;
        }
        blk->acc = (u16)sum;
        break;
    case 1: /* slide-down */
        sum = (s32)acc - (s32)cfg->w2;
        if (sum <= (s32)cfg->w4) {
            sum = cfg->w4;
            *pFlags = (flags & (u32)-7) | 4u;
        }
        blk->acc = (u16)sum;
        break;
    case 2: /* kickoff: maybe advance to mode 3 */
        if (flags & 0x10) {
            flags = (flags & (u32)-7) | 6u; /* bits 1-2 = 11, i.e. mode 3 */
            *pFlags = flags;
        }
        /* fall through */
    case 3: /* converge */
        sum = (s32)acc - (s32)cfg->w6;
        if (sum <= 0xff) {
            sum = 0;
            *pFlags = *pFlags & ~7u;
        }
        blk->acc = (u16)sum;
        break;
    }

    if ((acc & 0xff00) != (prevAcc & 0xff00))
        *pFlags = *pFlags | dirtyBit;
}

static void envelope_c_inactive_tick(EnvelopeCBlock *blk, u32 *pFlags, u32 flags, u32 dirtyBit)
{
    u16 prevAcc = blk->acc;
    s32 delta = (s32)(u32)blk->cfg;
    s32 sum = (s32)prevAcc + delta;

    if (delta >= 0) {
        if (sum > 0xfeff) {
            flags &= (u32)-0x21;
            *pFlags = flags;
            sum = 0xff00;
        }
    } else {
        if (sum <= 0x100) {
            flags &= (u32)-0x21;
            *pFlags = flags;
            sum = 0;
        }
    }

    blk->acc = (u16)sum;
    if ((prevAcc & 0xff00) != (sum & 0xff00))
        *pFlags = *pFlags | dirtyBit;
}
#else
NAKED
void sub_0802F054(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    movs    r0, #0xf0\n"
        "    lsls    r0, r0, #8\n"
        "    mov     sl, r0\n"
        "    movs    r1, #0x8c\n"
        "    mov     r9, r1\n"
        "    movs    r2, #0\n"
        "    mov     ip, r2\n"
        "    movs    r3, #3\n"
        "    mov     r8, r3\n"
        "_0802F070:\n"
        "    ldr     r5, _0802F0A8            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r2, [r5, #0]\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0x10\n"
        "    mov     r1, ip\n"
        "    adds    r6, r0, r1\n"
        "    ldr     r1, [r6, #0]\n"
        "    movs    r0, #1\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F13C\n"
        "    mov     r3, r9\n"
        "    adds    r5, r2, r3\n"
        "    adds    r7, r5, #4\n"
        "    ldrh    r4, [r5, #4]\n"
        "    movs    r2, #6\n"
        "    adds    r0, r1, #0\n"
        "    ands    r0, r2\n"
        "    lsrs    r0, r0, #1\n"
        "    cmp     r0, #1\n"
        "    beq     _0802F0D0\n"
        "    cmp     r0, #1\n"
        "    bcc     _0802F0AC\n"
        "    cmp     r0, #2\n"
        "    beq     _0802F0EE\n"
        "    cmp     r0, #3\n"
        "    beq     _0802F100\n"
        "    b       _0802F122\n"
        "    .align  2, 0\n"
        "_0802F0A8: .4byte 0x030065e0\n"
        "_0802F0AC:\n"
        "    ldr     r0, [r5, #0]\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r3, r0, r4\n"
        "    ldr     r0, _0802F0CC\n"
        "    cmp     r3, r0\n"
        "    ble     _0802F0EA\n"
        "    movs    r0, #7\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    movs    r0, #2\n"
        "    orrs    r1, r0\n"
        "    str     r1, [r6, #0]\n"
        "    movs    r3, #0xff\n"
        "    lsls    r3, r3, #8\n"
        "    b       _0802F0EA\n"
        "    .align  2, 0\n"
        "_0802F0CC: .4byte 0x0000feff\n"
        "_0802F0D0:\n"
        "    ldr     r0, [r5, #0]\n"
        "    ldrh    r2, [r0, #2]\n"
        "    subs    r3, r4, r2\n"
        "    ldrh    r0, [r0, #4]\n"
        "    cmp     r3, r0\n"
        "    bgt     _0802F0EA\n"
        "    adds    r3, r0, #0\n"
        "    movs    r0, #7\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    movs    r0, #4\n"
        "    orrs    r1, r0\n"
        "    str     r1, [r6, #0]\n"
        "_0802F0EA:\n"
        "    strh    r3, [r5, #4]\n"
        "    b       _0802F122\n"
        "_0802F0EE:\n"
        "    movs    r0, #0x10\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F122\n"
        "    movs    r3, #7\n"
        "    negs    r3, r3\n"
        "    ands    r1, r3\n"
        "    orrs    r1, r2\n"
        "    str     r1, [r6, #0]\n"
        "_0802F100:\n"
        "    ldr     r0, [r5, #0]\n"
        "    ldrh    r5, [r7, #0]\n"
        "    ldrh    r0, [r0, #6]\n"
        "    subs    r3, r5, r0\n"
        "    cmp     r3, #0xff\n"
        "    bgt     _0802F120\n"
        "    movs    r3, #0\n"
        "    ldr     r1, _0802F138\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0x10\n"
        "    add     r0, ip\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r2, #8\n"
        "    negs    r2, r2\n"
        "    ands    r1, r2\n"
        "    str     r1, [r0, #0]\n"
        "_0802F120:\n"
        "    strh    r3, [r7, #0]\n"
        "_0802F122:\n"
        "    mov     r2, sl\n"
        "    ands    r4, r2\n"
        "    mov     r0, sl\n"
        "    ldrh    r7, [r7, #0]\n"
        "    ands    r0, r7\n"
        "    cmp     r4, r0\n"
        "    beq     _0802F19A\n"
        "    ldr     r3, _0802F138\n"
        "    ldr     r0, [r3, #0]\n"
        "    b       _0802F18E\n"
        "    .align  2, 0\n"
        "_0802F138: .4byte 0x030065e0\n"
        "_0802F13C:\n"
        "    movs    r0, #0x20\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F19A\n"
        "    mov     r5, r9\n"
        "    adds    r0, r2, r5\n"
        "    adds    r7, r0, #4\n"
        "    ldrh    r4, [r0, #4]\n"
        "    ldr     r0, [r0, #0]\n"
        "    adds    r3, r4, r0\n"
        "    cmp     r0, #0\n"
        "    blt     _0802F16C\n"
        "    ldr     r0, _0802F168\n"
        "    cmp     r3, r0\n"
        "    ble     _0802F17E\n"
        "    movs    r0, #0x21\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    str     r1, [r6, #0]\n"
        "    movs    r3, #0xff\n"
        "    lsls    r3, r3, #8\n"
        "    b       _0802F17E\n"
        "    .align  2, 0\n"
        "_0802F168: .4byte 0x0000feff\n"
        "_0802F16C:\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #1\n"
        "    cmp     r3, r0\n"
        "    bgt     _0802F17E\n"
        "    movs    r0, #0x21\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    str     r1, [r6, #0]\n"
        "    movs    r3, #0\n"
        "_0802F17E:\n"
        "    strh    r3, [r7, #0]\n"
        "    mov     r0, sl\n"
        "    ands    r4, r0\n"
        "    ands    r3, r0\n"
        "    cmp     r4, r3\n"
        "    beq     _0802F19A\n"
        "    ldr     r1, _0802F20C\n"
        "    ldr     r0, [r1, #0]\n"
        "_0802F18E:\n"
        "    adds    r0, #0x10\n"
        "    add     r0, ip\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r2, #0x80\n"
        "    orrs    r1, r2\n"
        "    str     r1, [r0, #0]\n"
        "_0802F19A:\n"
        "    movs    r2, #8\n"
        "    add     r9, r2\n"
        "    movs    r3, #4\n"
        "    add     ip, r3\n"
        "    movs    r5, #1\n"
        "    negs    r5, r5\n"
        "    add     r8, r5\n"
        "    mov     r0, r8\n"
        "    cmp     r0, #0\n"
        "    blt     _0802F1B0\n"
        "    b       _0802F070\n"
        "_0802F1B0:\n"
        "    movs    r1, #0\n"
        "    mov     r8, r1\n"
        "    ldr     r1, _0802F20C\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r8, r0\n"
        "    blt     _0802F1C0\n"
        "    b       _0802F2E8\n"
        "_0802F1C0:\n"
        "    subs    r2, #0xf\n"
        "    mov     r9, r2\n"
        "    movs    r6, #0xff\n"
        "    lsls    r6, r6, #8\n"
        "_0802F1C8:\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r1, [r0, #0]\n"
        "    mov     r3, r8\n"
        "    lsls    r0, r3, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r2, [r0, #0]\n"
        "    cmp     r2, #0\n"
        "    bne     _0802F1DC\n"
        "    b       _0802F2D8\n"
        "_0802F1DC:\n"
        "    ldr     r1, [r2, #0x38]\n"
        "    movs    r0, #1\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F284\n"
        "    adds    r5, r2, #0\n"
        "    adds    r5, #0x24\n"
        "    adds    r7, r2, #0\n"
        "    adds    r7, #0x28\n"
        "    ldrh    r4, [r2, #0x28]\n"
        "    movs    r3, #6\n"
        "    adds    r0, r1, #0\n"
        "    ands    r0, r3\n"
        "    lsrs    r0, r0, #1\n"
        "    cmp     r0, #1\n"
        "    beq     _0802F230\n"
        "    cmp     r0, #1\n"
        "    bcc     _0802F210\n"
        "    cmp     r0, #2\n"
        "    beq     _0802F24C\n"
        "    cmp     r0, #3\n"
        "    beq     _0802F25C\n"
        "    b       _0802F276\n"
        "    .align  2, 0\n"
        "_0802F20C: .4byte 0x030065e0\n"
        "_0802F210:\n"
        "    ldr     r0, [r2, #0x24]\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r3, r0, r4\n"
        "    ldr     r0, _0802F22C\n"
        "    cmp     r3, r0\n"
        "    ble     _0802F248\n"
        "    mov     r5, r9\n"
        "    ands    r1, r5\n"
        "    movs    r0, #2\n"
        "    orrs    r1, r0\n"
        "    str     r1, [r2, #0x38]\n"
        "    movs    r3, #0xff\n"
        "    lsls    r3, r3, #8\n"
        "    b       _0802F248\n"
        "    .align  2, 0\n"
        "_0802F22C: .4byte 0x0000feff\n"
        "_0802F230:\n"
        "    ldr     r0, [r2, #0x24]\n"
        "    ldrh    r5, [r0, #2]\n"
        "    subs    r3, r4, r5\n"
        "    ldrh    r0, [r0, #4]\n"
        "    cmp     r3, r0\n"
        "    bgt     _0802F248\n"
        "    adds    r3, r0, #0\n"
        "    mov     r0, r9\n"
        "    ands    r1, r0\n"
        "    movs    r0, #4\n"
        "    orrs    r1, r0\n"
        "    str     r1, [r2, #0x38]\n"
        "_0802F248:\n"
        "    strh    r3, [r2, #0x28]\n"
        "    b       _0802F276\n"
        "_0802F24C:\n"
        "    movs    r0, #0x10\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F276\n"
        "    mov     r0, r9\n"
        "    ands    r1, r0\n"
        "    orrs    r1, r3\n"
        "    str     r1, [r2, #0x38]\n"
        "_0802F25C:\n"
        "    ldr     r0, [r5, #0]\n"
        "    ldrh    r1, [r7, #0]\n"
        "    ldrh    r0, [r0, #6]\n"
        "    subs    r3, r1, r0\n"
        "    cmp     r3, #0xff\n"
        "    bgt     _0802F274\n"
        "    movs    r3, #0\n"
        "    ldr     r0, [r2, #0x38]\n"
        "    movs    r1, #8\n"
        "    negs    r1, r1\n"
        "    ands    r0, r1\n"
        "    str     r0, [r2, #0x38]\n"
        "_0802F274:\n"
        "    strh    r3, [r7, #0]\n"
        "_0802F276:\n"
        "    ands    r4, r6\n"
        "    adds    r0, r6, #0\n"
        "    ldrh    r7, [r7, #0]\n"
        "    ands    r0, r7\n"
        "    cmp     r4, r0\n"
        "    beq     _0802F2D8\n"
        "    b       _0802F2D0\n"
        "_0802F284:\n"
        "    movs    r0, #0x20\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802F2D8\n"
        "    adds    r7, r2, #0\n"
        "    adds    r7, #0x28\n"
        "    ldrh    r4, [r2, #0x28]\n"
        "    ldr     r0, [r2, #0x24]\n"
        "    adds    r3, r4, r0\n"
        "    cmp     r0, #0\n"
        "    blt     _0802F2B4\n"
        "    ldr     r0, _0802F2B0\n"
        "    cmp     r3, r0\n"
        "    ble     _0802F2C6\n"
        "    movs    r0, #0x21\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    str     r1, [r2, #0x38]\n"
        "    movs    r3, #0xff\n"
        "    lsls    r3, r3, #8\n"
        "    b       _0802F2C6\n"
        "    .align  2, 0\n"
        "_0802F2B0: .4byte 0x0000feff\n"
        "_0802F2B4:\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #1\n"
        "    cmp     r3, r0\n"
        "    bgt     _0802F2C6\n"
        "    movs    r0, #0x21\n"
        "    negs    r0, r0\n"
        "    ands    r1, r0\n"
        "    str     r1, [r2, #0x38]\n"
        "    movs    r3, #0\n"
        "_0802F2C6:\n"
        "    strh    r3, [r7, #0]\n"
        "    ands    r4, r6\n"
        "    ands    r3, r6\n"
        "    cmp     r4, r3\n"
        "    beq     _0802F2D8\n"
        "_0802F2D0:\n"
        "    ldr     r0, [r2, #0x38]\n"
        "    movs    r1, #0x80\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r2, #0x38]\n"
        "_0802F2D8:\n"
        "    movs    r2, #1\n"
        "    add     r8, r2\n"
        "    ldr     r1, _0802F2F8\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r8, r0\n"
        "    bge     _0802F2E8\n"
        "    b       _0802F1C8\n"
        "_0802F2E8:\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0x0000\n"
        "_0802F2F8: .4byte 0x030065e0\n"
        "    .syntax divided\n");
}
#endif
