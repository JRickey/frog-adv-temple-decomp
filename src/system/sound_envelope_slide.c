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
 *   mode 0 — slide-up:    sum = acc + cfg->slideUpStep; if sum > 0xfeff, clamp at
 *                          0xff00 and set mode := 1 (bits 1-2 = 01).
 *   mode 1 — slide-down:  sum = acc - cfg->slideDownStep; if sum > cfg->slideDownClamp,
 *                          write sum; else clamp at cfg->slideDownClamp and
 *                          set mode := 2 (bits 1-2 = 10).
 *   mode 2 — kickoff:     if flags & 0x10, set bits 1-2 := 3 (= "stop"
 *                          phase) and fall through to mode 3.
 *   mode 3 — converge:    diff = (s32)w_acc - cfg->convergeStep; if diff > 0xff,
 *                          write diff; else clear bits 0-2 of flags and pin
 *                          acc at 0.
 *
 * After each branch the channel-level acc and change mask decide whether
 * the channel-flags dirty bit SOUND_FLAG_UPDATE_DIRTY is OR'd in: stage 1 uses a 0xf000 mask,
 * while the per-slot stage uses 0xff00.
 *
 * Stage 1 (4 iterations, fixed): four inline channel envelope blocks
 * embedded in SoundSystem itself at ss+0x8c, ss+0x94, ss+0x9c, ss+0xa4
 * (stride 8). Walked i=3 down to 0 (loop counter in r8, decremented to
 * -1). Mode dispatch only fires if chFlags[i] & 1 is set; otherwise
 * the inactive slide path runs if SOUND_FLAG_ENVELOPE_C_INACTIVE is set,
 * advancing the accumulator until it clamps and clears that bit.
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
 * corpus-validated unmatchable". The current reference body uses the target's
 * stage-1 block/flag pairing (blocks +0x8c..+0xa4 paired with chFlags
 * 0..3, not reversed). Register-shaping the active tick block around the
 * target's r5/r6/r7/r4 roles, then using a stage-1-only active macro so the
 * 0xf000 mask can stay in sl, and routing the stage-1 gpSoundSystem load
 * through a scoped r5 pointer drops the best isolated C candidate. Leaving the
 * active dispatcher to reload blk_->param.cfg at each use, instead of caching a cfg_
 * local, gives the current best forced-C lane. Splitting the stage-1 flag
 * base from the `ip` add and keeping the loaded SoundSystem in r2 improves
 * the current exact-size lane to byte_diff 585 / diff_count 395 with agbcc
 * -O2 -fforce-addr -fno-gcse. The readable C is preserved behind
 * NON_MATCHING for the phase-3 PC port; the NAKED form ships the baserom
 * bytes.
 *
 * Negative experiments: removing the active tick's mask/dirty temporaries
 * regressed to byte_diff 604, and applying the same register shape to the
 * inactive path regressed to byte_diff 605. Pinning the stage-2 active mask
 * to r6, to mirror the target's per-slot mask role, regressed the best lane
 * to byte_diff 594. Rewriting the stage-2 `for` loop as an explicit loop with
 * an r1 initializer was codegen-neutral and is not kept. Pinning the inactive
 * sum temp to r3 moved one local pattern closer but regressed the best lane to
 * byte_diff 606+ by displacing the flags register. Retesting `(flags & 6) >> 1`
 * after the stage-1 r5 reload still regressed byte_diff to 596, and pinning a
 * stage-2 gpSoundSystem pointer to r1 regressed the best lane to 580. Replacing
 * the stage-1 switch with an explicit target-looking if ladder regressed
 * byte_diff to 589, and pinning the stage-1 flags value to r1 regressed to 566.
 * Rewriting the mode extraction and clamp/mask literals through named
 * envelope-C constants changed expression shape and regressed the best lane
 * to byte_diff 599; pure macro names that expand back to the same literals are
 * codegen-neutral and retained.
 * Retesting stage-1 gpSoundSystem register shaping on the current branch:
 * forcing the loaded SoundSystem through r2 is only helpful after the flag-base
 * address expression is split; wrapping the whole stage-1 active/inactive block
 * in that scoped load regresses to byte_diff 597, pinning the initial loop value
 * to r3 is neutral, and pinning the pFlags pointer globally to r6 regresses by
 * one byte.
 * Second-pass current-branch retests: target-looking mode extraction
 * `(flags & 6) >> 1` regresses when applied to stage 1, but applying it only
 * to the generic slot macro and pairing it with a scoped stage-2
 * gpSoundSystem reload loop improves the raw forced-C byte lane to 557.
 * Pinning the generic slot tick's previous-accumulator temp to r3 improves that to 552
 * without changing object size.
 * Pinning stage-1 flags to r1 regresses to 566, stage-1 acc to r3 regresses to
 * 600, a target-looking stage-1 if ladder regresses to 622, and inactive-path
 * u32/r4 variants regress to 584+. These failures point at the whole macro
 * expansion/control-flow shape rather than one visible expression.
 * Fixed-r2 and fixed-r3 compiler lanes can lower byte_diff into the 540s, but
 * they remove registers the baserom uses in the opening dispatcher and worsen
 * instruction alignment, so they are not encoded in the Makefile. Naming the
 * envelope-C first word as a cfg/delta union and naming the stage-1 channel
 * union owner are codegen-neutral in the current exact-size lane, but preserve
 * the two real data shapes used by the active and inactive paths.
 */

/* Per-mode configuration block referenced by ch_block->param.cfg. Halfwords
 * laid out so the dispatch can index them by mode. Inactive slides reuse the
 * same first word as a signed delta. */
#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_0802F054)
#define ENVELOPE_C_TICK(blkExpr, pFlagsExpr, flagsExpr, maskExpr, dirtyExpr)                                           \
    do {                                                                                                               \
        register EnvelopeCBlock *blk_ asm("r5") = (blkExpr);                                                           \
        register u32 *pFlags_ asm("r6") = (pFlagsExpr);                                                                \
        register u16 *accp_ asm("r7") = &blk_->acc;                                                                    \
        u32 flags_ = (flagsExpr);                                                                                      \
        u32 mask_ = (maskExpr);                                                                                        \
        u32 dirty_ = (dirtyExpr);                                                                                      \
        register u16 prevAcc_ asm("r3") = *accp_;                                                                      \
        u16 acc_ = prevAcc_;                                                                                           \
        s32 sum_;                                                                                                      \
        s32 mode_ = (flags_ & SOUND_ENVELOPE_C_MODE_BITS) >> 1;                                                        \
                                                                                                                       \
        switch (mode_) {                                                                                               \
        case 0:                                                                                                        \
            sum_ = (s32)blk_->param.cfg->slideUpStep + (s32)acc_;                                                      \
            if (sum_ > SOUND_ENVELOPE_C_HIGH_LIMIT) {                                                                  \
                *pFlags_ = (flags_ & SOUND_ENVELOPE_C_CLEAR_MODE) | SOUND_ENVELOPE_C_MODE_SLIDE_DOWN;                  \
                sum_ = SOUND_ENVELOPE_C_HIGH_CLAMP;                                                                    \
            }                                                                                                          \
            blk_->acc = (u16)sum_;                                                                                     \
            break;                                                                                                     \
        case 1:                                                                                                        \
            sum_ = (s32)acc_ - (s32)blk_->param.cfg->slideDownStep;                                                    \
            if (sum_ <= (s32)blk_->param.cfg->slideDownClamp) {                                                        \
                sum_ = blk_->param.cfg->slideDownClamp;                                                                \
                *pFlags_ = (flags_ & SOUND_ENVELOPE_C_CLEAR_MODE) | SOUND_ENVELOPE_C_MODE_KICKOFF;                     \
            }                                                                                                          \
            blk_->acc = (u16)sum_;                                                                                     \
            break;                                                                                                     \
        case 2:                                                                                                        \
            if (flags_ & SOUND_ENVELOPE_C_FLAG_KICKOFF) {                                                              \
                flags_ = (flags_ & SOUND_ENVELOPE_C_CLEAR_MODE) | SOUND_ENVELOPE_C_MODE_STOP;                          \
                *pFlags_ = flags_;                                                                                     \
            }                                                                                                          \
        case 3:                                                                                                        \
            sum_ = (s32)acc_ - (s32)blk_->param.cfg->convergeStep;                                                     \
            if (sum_ <= SOUND_ENVELOPE_C_CONVERGE_LIMIT) {                                                             \
                sum_ = 0;                                                                                              \
                *pFlags_ = *pFlags_ & ~7u;                                                                             \
            }                                                                                                          \
            blk_->acc = (u16)sum_;                                                                                     \
            break;                                                                                                     \
        }                                                                                                              \
                                                                                                                       \
        if ((blk_->acc & mask_) != (prevAcc_ & mask_))                                                                 \
            *pFlags_ = *pFlags_ | dirty_;                                                                              \
    } while (0)

#define ENVELOPE_C_STAGE1_TICK(blkExpr, pFlagsExpr, flagsExpr, maskExpr)                                               \
    do {                                                                                                               \
        register EnvelopeCBlock *blk_ asm("r5") = (blkExpr);                                                           \
        register u32 *pFlags_ asm("r6") = (pFlagsExpr);                                                                \
        register u16 *accp_ asm("r7") = &blk_->acc;                                                                    \
        u32 flags_ = (flagsExpr);                                                                                      \
        register u16 prevAcc_ asm("r4") = *accp_;                                                                      \
        u16 acc_ = prevAcc_;                                                                                           \
        s32 sum_;                                                                                                      \
        register s32 mode_ asm("r0") = (flags_ >> 1) & SOUND_ENVELOPE_C_MODE_MASK;                                     \
                                                                                                                       \
        switch (mode_) {                                                                                               \
        case 0:                                                                                                        \
            sum_ = (s32)blk_->param.cfg->slideUpStep + (s32)acc_;                                                      \
            if (sum_ > SOUND_ENVELOPE_C_HIGH_LIMIT) {                                                                  \
                *pFlags_ = (flags_ & SOUND_ENVELOPE_C_CLEAR_MODE) | SOUND_ENVELOPE_C_MODE_SLIDE_DOWN;                  \
                sum_ = SOUND_ENVELOPE_C_HIGH_CLAMP;                                                                    \
            }                                                                                                          \
            blk_->acc = (u16)sum_;                                                                                     \
            break;                                                                                                     \
        case 1:                                                                                                        \
            sum_ = (s32)acc_ - (s32)blk_->param.cfg->slideDownStep;                                                    \
            if (sum_ <= (s32)blk_->param.cfg->slideDownClamp) {                                                        \
                sum_ = blk_->param.cfg->slideDownClamp;                                                                \
                *pFlags_ = (flags_ & SOUND_ENVELOPE_C_CLEAR_MODE) | SOUND_ENVELOPE_C_MODE_KICKOFF;                     \
            }                                                                                                          \
            blk_->acc = (u16)sum_;                                                                                     \
            break;                                                                                                     \
        case 2:                                                                                                        \
            if (flags_ & SOUND_ENVELOPE_C_FLAG_KICKOFF) {                                                              \
                flags_ = (flags_ & SOUND_ENVELOPE_C_CLEAR_MODE) | SOUND_ENVELOPE_C_MODE_STOP;                          \
                *pFlags_ = flags_;                                                                                     \
            }                                                                                                          \
        case 3:                                                                                                        \
            sum_ = (s32)acc_ - (s32)blk_->param.cfg->convergeStep;                                                     \
            if (sum_ <= SOUND_ENVELOPE_C_CONVERGE_LIMIT) {                                                             \
                sum_ = 0;                                                                                              \
                *pFlags_ = *pFlags_ & ~7u;                                                                             \
            }                                                                                                          \
            blk_->acc = (u16)sum_;                                                                                     \
            break;                                                                                                     \
        }                                                                                                              \
                                                                                                                       \
        if ((blk_->acc & (maskExpr)) != (prevAcc_ & (maskExpr)))                                                       \
            *pFlags_ = *pFlags_ | SOUND_FLAG_UPDATE_DIRTY;                                                             \
    } while (0)

#define ENVELOPE_C_INACTIVE_TICK(blkExpr, pFlagsExpr, flagsExpr, maskExpr, dirtyExpr)                                  \
    do {                                                                                                               \
        EnvelopeCBlock *blk_ = (blkExpr);                                                                              \
        u32 *pFlags_ = (pFlagsExpr);                                                                                   \
        u32 flags_ = (flagsExpr);                                                                                      \
        u32 mask_ = (maskExpr);                                                                                        \
        u32 dirty_ = (dirtyExpr);                                                                                      \
        u16 prevAcc_ = blk_->acc;                                                                                      \
        s32 delta_ = blk_->param.inactiveDelta;                                                                        \
        s32 sum_ = (s32)prevAcc_ + delta_;                                                                             \
                                                                                                                       \
        if (delta_ >= 0) {                                                                                             \
            if (sum_ > SOUND_ENVELOPE_C_HIGH_LIMIT) {                                                                  \
                flags_ &= ~SOUND_FLAG_ENVELOPE_C_INACTIVE;                                                             \
                *pFlags_ = flags_;                                                                                     \
                sum_ = SOUND_ENVELOPE_C_HIGH_CLAMP;                                                                    \
            }                                                                                                          \
        } else {                                                                                                       \
            if (sum_ <= SOUND_ENVELOPE_C_LOW_LIMIT) {                                                                  \
                flags_ &= ~SOUND_FLAG_ENVELOPE_C_INACTIVE;                                                             \
                *pFlags_ = flags_;                                                                                     \
                sum_ = 0;                                                                                              \
            }                                                                                                          \
        }                                                                                                              \
                                                                                                                       \
        blk_->acc = (u16)sum_;                                                                                         \
        if ((blk_->acc & mask_) != (prevAcc_ & mask_))                                                                 \
            *pFlags_ = *pFlags_ | dirty_;                                                                              \
    } while (0)

void sub_0802F054(void)
{
    SoundSystem *ss;
    SoundSlot *slot;
    register s32 i asm("r8");
    register s32 blockOff asm("r9");
    register s32 flagOff asm("ip");
    register u32 stageMask asm("sl");
    u32 flags;
    u32 *pFlags;
    EnvelopeCBlock *blk;
    SoundEnvelopeCChannel *channel;

    /* Stage 1: 4 inline channel envelope blocks at ss+0x8c, +0x94, +0x9c,
     * +0xa4 (stride 8). Loop counter walks down 3 -> 0. */
    stageMask = SOUND_ENVELOPE_C_STAGE1_MASK;
    blockOff = SOUND_ENVELOPE_C_CHANNEL_BASE;
    flagOff = 0;
    i = SOUND_ENVELOPE_C_CHANNEL_COUNT - 1;
    do {
        {
            register SoundSystem **gpsp asm("r5");
            register SoundSystem *ssStage asm("r2");
            u8 *flagBase;

            gpsp = &gpSoundSystem;
            ssStage = *gpsp;
            ss = ssStage;
            flagBase = (u8 *)ssStage + SOUND_CH_FLAGS_OFFSET;
            pFlags = (u32 *)(flagBase + flagOff);
        }
        flags = *pFlags;
        if (flags & SOUND_FLAG_ENVELOPE_C_ACTIVE) {
            channel = SOUND_SYSTEM_ENVELOPE_C_CHANNEL_AT(ss, blockOff);
            blk = &channel->envelopeC;
            ENVELOPE_C_STAGE1_TICK(blk, pFlags, flags, stageMask);
        } else if (flags & SOUND_FLAG_ENVELOPE_C_INACTIVE) {
            channel = SOUND_SYSTEM_ENVELOPE_C_CHANNEL_AT(ss, blockOff);
            blk = &channel->envelopeC;
            ENVELOPE_C_INACTIVE_TICK(blk, pFlags, flags, stageMask, SOUND_FLAG_UPDATE_DIRTY);
        }
        blockOff += SOUND_ENVELOPE_C_CHANNEL_STRIDE;
        flagOff += SOUND_CH_FLAGS_STRIDE;
        i--;
    } while (i >= 0);

    /* Stage 2: per-slot envelope-C, walked via slotPtrTable[0..count). */
    i = 0;
    for (;;) {
        register SoundSystem **gpsp2 asm("r1");
        SoundSystem *ss2;

        gpsp2 = &gpSoundSystem;
        ss2 = *gpsp2;
        if (i >= ss2->count)
            break;
        slot = SOUND_SYSTEM_SLOT_PTR_TABLE(ss2)[i];
        if (slot != NULL) {
            flags = slot->flags;
            if (flags & SOUND_FLAG_ENVELOPE_C_ACTIVE) {
                ENVELOPE_C_TICK(SOUND_SLOT_ENVELOPE_C(slot), &slot->flags, flags, SOUND_ENVELOPE_C_SLOT_MASK,
                                SOUND_FLAG_UPDATE_DIRTY);
            } else if (flags & SOUND_FLAG_ENVELOPE_C_INACTIVE) {
                ENVELOPE_C_INACTIVE_TICK(SOUND_SLOT_ENVELOPE_C(slot), &slot->flags, flags, SOUND_ENVELOPE_C_SLOT_MASK,
                                         SOUND_FLAG_UPDATE_DIRTY);
            }
        }
        i++;
    }
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
