#include "sound.h"
#include "macros.h"

/* sub_0802EA80 — per-frame countdown-bounce envelope tick (envelope-A0).
 *
 * Sister of sub_0802EC7C in sound_channel.c. Same two-stage shape — three
 * inline channel envelopes embedded in SoundSystem itself, then a per-slot
 * bank walked via slotPtrTable — but each channel/slot exposes a SECOND
 * envelope block at +0x14 (envelope-A0), and the bounce model is different:
 * a 1-byte countdown ticks down each frame and, on 0xff underflow, reloads
 * from a paired reload byte while negating the envelope step. No
 * triangular acc-limit clamp here; the envelope simply oscillates on a
 * fixed frame schedule.
 *
 * Stage 1 (3 iterations, fixed): three inline channel envelopes embedded
 * in SoundSystem itself at ss+0x34, ss+0x58, ss+0x7c (stride 36, envelope
 * at +0x14 inside each). On every step the envelope step is accumulated
 * into the envelope acc; when the countdown wraps from 0 to 0xff, the
 * step is negated and the countdown is reloaded. Whenever step != 0
 * (whether or not a bounce fired) ss->chFlags[i] gets a 0x40 dirty bit
 * ORd in.
 *
 * Stage 2 (ss->count iterations): per-slot envelope-A0 bank, walked via
 * ss->slotPtrTable[i]. Same accumulate + countdown-bounce shape; on each
 * tick the slot flags get 0x40 ORd in (whenever the slot is present and
 * step is non-zero).
 *
 * Matching notes:
 *   - `i`, `offset`, and the gpSoundSystem mirror are pinned to match the
 *     baserom's two-stage loop lifetime.
 *   - The inline `add` preserves the ROM's commutative Thumb encoding; agbcc
 *     otherwise emits the operands in the opposite order.
 */

void sub_0802EA80(void)
{
    register SoundSystem **gpsp asm("ip");
    register SoundSystem **gpspMirror asm("r6");
    register SoundSystem **gpCheck asm("r1");
    SoundSystem *ss;
    SoundSlot *slot;
    SlotEnvelopeA0 *env;
    register s32 i asm("r4");
    register s32 offset asm("r5");
    s16 step;
    u16 acc;
    s32 ctr;

    i = 0;
    gpsp = &gpSoundSystem;
    gpspMirror = gpsp;
    offset = SOUND_INLINE_CHANNEL_BASE_OFFSET;

    /* Stage 1: three inline channel envelopes embedded in SoundSystem
     * itself at ss+0x34, ss+0x58, ss+0x7c (stride 36, envelope at +0x14
     * inside each). */
    do {
        ss = *gpspMirror;
        env = SOUND_INLINE_CHANNEL_ENVELOPE_A0_AT(ss, offset);
        step = env->step;
        if (step != 0) {
            acc = env->acc;
            asm("add %0, %1, %2" : "=r"(acc) : "r"(step), "r"(acc));
            env->acc = acc;
            ctr = env->countdown - 1;
            env->countdown = ctr;
            ctr = (u8)ctr;
            if (ctr == SOUND_ENVELOPE_COUNTDOWN_UNDERFLOW) {
                env->countdown = env->reload;
                env->step = -env->step;
            }
            {
                s32 flagOffset;
                register u32 *flags asm("r2");

                flags = (u32 *)*gpspMirror;
                flagOffset = i << 2;
                flags = (u32 *)((u8 *)flags + SOUND_CH_FLAGS_OFFSET);
                flags = (u32 *)((u8 *)flags + flagOffset);
                *flags |= SOUND_FLAG_ENV_DIRTY;
            }
        }
        offset += SOUND_INLINE_CHANNEL_STRIDE;
        i++;
    } while (i <= SOUND_INLINE_CHANNEL_COUNT - 1);

    /* Stage 2: per-slot envelope-A0 bank, walked via slotPtrTable. */
    i = 0;
    goto count_check;
body:
    slot = SOUND_SYSTEM_SLOT_PTR_TABLE(*gpCheck)[i];
    if (slot != NULL) {
        env = &slot->envelopeA0;
        step = env->step;
        if (step != 0) {
            acc = env->acc;
            asm("add %0, %1, %2" : "=r"(acc) : "r"(step), "r"(acc));
            env->acc = acc;
            ctr = env->countdown - 1;
            env->countdown = ctr;
            ctr = (u8)ctr;
            if (ctr == SOUND_ENVELOPE_COUNTDOWN_UNDERFLOW) {
                env->countdown = env->reload;
                env->step = -env->step;
            }
            slot->flags |= SOUND_FLAG_ENV_DIRTY;
        }
    }
    i++;
count_check:
    gpCheck = gpsp;
    if (i < (*gpCheck)->count)
        goto body;
}

/* SoundEnvelope_SetRamp configures the clamp envelope (envelope-A at +0x1c) for
 * one channel. Shipped NAKED + NON_MATCHING: classify_unmatchable reports
 * class3-libgcc (wide r4-r7 prologue plus lone __divsi3 BL). The readable
 * C bottoms out at byte_diff 126 because agbcc's final jump2 cross-jump
 * pass merges the per-branch divide tails and swaps the target/frame high
 * register homes; no available -f option suppresses that pass.
 *
 * Corpus: current-tree C hits for __divsi3 are ordinary divisions or inline
 * asm strings; no pure-C precedent for this wide-prologue libgcc shape was
 * available, and corpus history mirrors are not populated in this worktree.
 */
#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_0802EB34)
void SoundEnvelope_SetRamp(u8 absolute, u16 target, u16 frames, s32 mode)
{
    SoundSystem *ss;
    SlotClampEnvelope *env;
    s32 delta;

    if (mode <= SOUND_INLINE_CHANNEL_COUNT - 1) {
        SoundSystem **gpp = &gpSoundSystem;
        s32 channelOffset = mode * SOUND_INLINE_CHANNEL_STRIDE + SOUND_INLINE_CHANNEL_BASE_OFFSET;
        u8 *channelView;

        ss = *gpp;
        channelView = (u8 *)ss + channelOffset;
        env = SOUND_SLOT_ENVELOPE_A((SoundSlot *)channelView);
        if (absolute) {
            u8 *channelBase = (u8 *)ss + mode * SOUND_INLINE_CHANNEL_STRIDE;
            s32 signedTarget = (s16)target;

            env->limit = signedTarget - *(u16 *)(channelBase + SOUND_INLINE_CHANNEL_BASE_OFFSET);
            delta = signedTarget - ((s16) * (s16 *)(channelBase + SOUND_INLINE_CHANNEL_BASE_OFFSET) +
                                    (s16) * (s16 *)(channelView + SOUND_SLOT_ENVELOPE_A_OFFSET));
        } else {
            delta = (s16)target;
            env->limit += delta;
        }
    } else {
        SoundSlot *swSlot;

        if (mode == SOUND_INLINE_CHANNEL_COUNT)
            return;

        swSlot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, mode);
        env = SOUND_SLOT_ENVELOPE_A(swSlot);
        if (absolute) {
            s32 signedTarget = (s16)target;

            env->limit = signedTarget - *(u16 *)swSlot;
            delta = signedTarget - ((s16) * (s16 *)swSlot + (s16)env->acc);
        } else {
            delta = (s16)target;
            env->limit += delta;
        }
    }

    env->step = delta / frames;
}
#else
NAKED
void SoundEnvelope_SetRamp(u8 absolute, u16 target, u16 frames, s32 mode)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, r8\n"
        "    push    {r7}\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r7, r0, #24\n"
        "    mov     ip, r7\n"
        "    lsls    r1, r1, #16\n"
        "    lsrs    r5, r1, #16\n"
        "    mov     r8, r5\n"
        "    lsls    r2, r2, #16\n"
        "    lsrs    r6, r2, #16\n"
        "    adds    r2, r6, #0\n"
        "    cmp     r3, #2\n"
        "    bgt     _0802EB96\n"
        "    ldr     r0, _0802EB84            @ =gpSoundSystem (0x030065e0)\n"
        "    lsls    r1, r3, #3\n"
        "    adds    r1, r1, r3\n"
        "    lsls    r2, r1, #2\n"
        "    adds    r1, r2, #0\n"
        "    adds    r1, #0x20\n"
        "    ldr     r0, [r0, #0]\n"
        "    adds    r3, r0, r1\n"
        "    adds    r4, r3, #0\n"
        "    adds    r4, #0x1c\n"
        "    cmp     r7, #0\n"
        "    beq     _0802EB88\n"
        "    adds    r2, r0, r2\n"
        "    lsls    r0, r5, #16\n"
        "    asrs    r0, r0, #16\n"
        "    ldrh    r5, [r2, #0x20]\n"
        "    subs    r1, r0, r5\n"
        "    strh    r1, [r4, #4]\n"
        "    movs    r5, #0x20\n"
        "    ldrsh   r1, [r2, r5]\n"
        "    movs    r5, #0x1c\n"
        "    ldrsh   r2, [r3, r5]\n"
        "    adds    r1, r1, r2\n"
        "    subs    r0, r0, r1\n"
        "    adds    r1, r6, #0\n"
        "    b       _0802EBE6\n"
        "    .align  2, 0\n"
        "_0802EB84: .4byte 0x030065e0\n"
        "_0802EB88:\n"
        "    lsls    r0, r5, #16\n"
        "    asrs    r0, r0, #16\n"
        "    ldrh    r2, [r4, #4]\n"
        "    adds    r1, r2, r0\n"
        "    strh    r1, [r4, #4]\n"
        "    adds    r1, r6, #0\n"
        "    b       _0802EBE6\n"
        "_0802EB96:\n"
        "    cmp     r3, #3\n"
        "    ble     _0802EBEC\n"
        "    ldr     r0, _0802EBD0            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r1, [r0, #0]\n"
        "    adds    r1, #0xc8\n"
        "    lsls    r0, r3, #6\n"
        "    ldr     r3, _0802EBD4            @ =-0x100\n"
        "    adds    r0, r0, r3\n"
        "    ldr     r1, [r1, #0]\n"
        "    adds    r3, r1, r0\n"
        "    adds    r4, r3, #0\n"
        "    adds    r4, #0x1c\n"
        "    mov     r0, ip\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EBD8\n"
        "    lsls    r0, r5, #16\n"
        "    asrs    r0, r0, #16\n"
        "    ldrh    r2, [r3, #0]\n"
        "    subs    r1, r0, r2\n"
        "    strh    r1, [r4, #4]\n"
        "    movs    r5, #0\n"
        "    ldrsh   r1, [r3, r5]\n"
        "    movs    r5, #0x1c\n"
        "    ldrsh   r2, [r3, r5]\n"
        "    adds    r1, r1, r2\n"
        "    subs    r0, r0, r1\n"
        "    adds    r1, r6, #0\n"
        "    b       _0802EBE6\n"
        "    .align  2, 0\n"
        "_0802EBD0: .4byte 0x030065e0\n"
        "_0802EBD4: .4byte 0xffffff00\n"
        "_0802EBD8:\n"
        "    mov     r1, r8\n"
        "    lsls    r0, r1, #16\n"
        "    asrs    r0, r0, #16\n"
        "    ldrh    r3, [r4, #4]\n"
        "    adds    r1, r3, r0\n"
        "    strh    r1, [r4, #4]\n"
        "    adds    r1, r2, #0\n"
        "_0802EBE6:\n"
        "    bl      __divsi3\n"
        "    strh    r0, [r4, #2]\n"
        "_0802EBEC:\n"
        "    pop     {r3}\n"
        "    mov     r8, r3\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0x0000\n"
        "    .syntax divided\n");
}
#endif

/* sub_0802EBF8 configures the clamp envelope-A (at +0x1c) for one channel,
 * initializing it from a SoundDrainEntry baseline value. Shipped NAKED +
 * NON_MATCHING: classify_unmatchable reports class3-libgcc (wide r4-r7
 * prologue plus a lone __divsi3 BL — agbcc emits a narrower prologue
 * because it knows libgcc helpers don't clobber r4-r7).
 *
 * Parameters: target (s16) in r0, frames (u16) in r1, mode (s32) in r2.
 * mode==3 → early return; mode 0..2 → inline channels; mode>=4 → sw slots.
 *
 * Logic: finds the SlotClampEnvelope, reads the SoundDrainEntry byte at
 * mode*12+7 from slot->nextRegion, computes
 *   env->limit = (s16)target + drainByte*256 - env->_pad06
 *   env->step  = env->limit / frames
 * and copies env->_pad06 to channel[0] (acc field).
 */
#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_0802EBF8)
void sub_0802EBF8(s16 target, u16 frames, s32 mode)
{
    SoundSystem *ss;
    SoundDrainEntry *drain;
    void *channel;
    SlotClampEnvelope *env;
    u16 pad06;
    s32 limit;
    u8 drainByte;

    if (mode == SOUND_INLINE_CHANNEL_COUNT)
        return;

    ss = gpSoundSystem;
    drain = &SOUND_REQUEST_DRAIN_ENTRIES(ss->slot)[mode];

    if (mode <= SOUND_INLINE_CHANNEL_COUNT - 1) {
        s32 off = mode * SOUND_INLINE_CHANNEL_STRIDE + SOUND_INLINE_CHANNEL_BASE_OFFSET;
        channel = (u8 *)ss + off;
    } else {
        channel = (u8 *)ss->swSlots + mode * SOUND_SW_SLOT_STRIDE - SOUND_SW_SLOT_STRIDE * 4;
    }

    env = SOUND_SLOT_ENVELOPE_A((SoundSlot *)channel);
    if (env == NULL)
        return;

    env->acc = 0;
    drainByte = ((u8 *)drain)[7];
    pad06 = *(u16 *)((u8 *)env + 6);
    limit = (s16)target + (drainByte << 8) - pad06;
    env->limit = limit;
    env->step = env->limit / frames;
    *(u16 *)channel = pad06;
}
#else
NAKED
void sub_0802EBF8(s16 target, u16 frames, s32 mode)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r7, r0, #16\n"
        "    lsls    r1, r1, #16\n"
        "    lsrs    r1, r1, #16\n"
        "    mov     ip, r1\n"
        "    cmp     r2, #3\n"
        "    beq     _0802EC70\n"
        "    ldr     r0, _0802EC34            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r3, [r0, #0]\n"
        "    movs    r1, #0x8c\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r0, r3, r1\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r0, #0x88\n"
        "    lsls    r0, r0, #1\n"
        "    adds    r1, r1, r0\n"
        "    lsls    r0, r2, #1\n"
        "    adds    r0, r0, r2\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, [r1, #0]\n"
        "    adds    r4, r1, r0\n"
        "    cmp     r2, #2\n"
        "    bgt     _0802EC38\n"
        "    lsls    r0, r2, #3\n"
        "    adds    r0, r0, r2\n"
        "    lsls    r0, r0, #2\n"
        "    adds    r0, #0x20\n"
        "    adds    r6, r3, r0\n"
        "    b       _0802EC46\n"
        "    .align  2, 0\n"
        "_0802EC34: .4byte 0x030065e0\n"
        "_0802EC38:\n"
        "    adds    r0, r3, #0\n"
        "    adds    r0, #0xc8\n"
        "    lsls    r1, r2, #6\n"
        "    ldr     r2, _0802EC78            @ =0xffffff00\n"
        "    adds    r1, r1, r2\n"
        "    ldr     r0, [r0, #0]\n"
        "    adds    r6, r0, r1\n"
        "_0802EC46:\n"
        "    adds    r5, r6, #0\n"
        "    adds    r5, #0x1c\n"
        "    cmp     r5, #0\n"
        "    beq     _0802EC70\n"
        "    movs    r0, #0\n"
        "    strh    r0, [r5, #0]\n"
        "    ldrb    r4, [r4, #7]\n"
        "    lsls    r1, r4, #8\n"
        "    lsls    r0, r7, #16\n"
        "    asrs    r0, r0, #16\n"
        "    adds    r0, r0, r1\n"
        "    ldrh    r4, [r5, #6]\n"
        "    subs    r0, r0, r4\n"
        "    strh    r0, [r5, #4]\n"
        "    movs    r1, #4\n"
        "    ldrsh   r0, [r5, r1]\n"
        "    mov     r1, ip\n"
        "    bl      __divsi3\n"
        "    strh    r0, [r5, #2]\n"
        "    strh    r4, [r6, #0]\n"
        "_0802EC70:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0x0000\n"
        "    .align  2, 0\n"
        "_0802EC78: .4byte 0xffffff00\n"
        "    .syntax divided\n");
}
#endif
