#include "sound.h"
#include "macros.h"

/* SoundSlot also has a SlotClampEnvelope "envelope A" block at +0x1c
 * (acc/step/limit s16s) that Sound_UpdateChannelEnvelopesA ticks. The per-slot
 * SlotEnvelope at +0x2c is the "envelope B" block ticked by Sound_TickSlotEnvelopeB.
 * Both share the same triangular-bounce shape and differ only in which
 * mix channel they modulate. This body keeps envelope-A as raw offsets
 * for now because typed SlotClampEnvelope access currently worsens
 * EC7C's linked codegen. */

/* Sound_UpdateChannelEnvelopesA — per-frame envelope-A tick + per-channel dirty flagging.
 *
 * Two stages run per call, both with the same triangular-bounce shape:
 *   Stage 1 (3 iterations, fixed): three inline channels embedded in
 *     SoundSystem itself (ss->channels[0..2]). Their envelope-A blocks
 *     are advanced; if a bounce is consumed (acc reaches ±limit, step is
 *     non-zero), the envelope step is zeroed and ss->chFlags[i] gets a
 *     0x40 dirty bit ORd in.
 *   Stage 2 (ss->count iterations): per-slot envelope-A bank, walked via
 *     ss->slotPtrTable[i]. Same bounce; on each tick the slot flags get
 *     0x40 ORd in unconditionally (whenever the slot is present and
 *     step is non-zero).
 *
 * Companion to Sound_TickSlotEnvelopeB, which runs the same shape over the per-slot
 * envelope-B bank (offset +0x2c). The envelope-A and envelope-B blocks
 * coexist on every slot.
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. The baserom
 * pins &gpSoundSystem into r8 (and ip) for stage 1 and reloads it via r8
 * for stage 2. Splitting this into its own translation unit made the
 * linked oracle meaningful. Pinning the stage-1 positive limit halfword to
 * r9 recovers the target high-register save pattern. Spelling stage 2 as a
 * labeled bottom-tested loop, then spelling the stage-1 dirty flag as a
 * `gpspReload` base plus a separate `flagIndex`, gives the current best
 * isolated C candidate. Routing the stage-1 and stage-2 body reloads of
 * `gpSoundSystem` through a scoped r1 pointer recovers the target load shape.
 * Mirroring the scoped zero local in stage 2 tightens the loop a little
 * further.
 * Keeping the stage-1 channel offset in r7, introducing the clear value
 * as a scoped r6 local, splitting stage-1 step into unsigned/add and
 * signed/test forms, and spelling the stage-1 dirty flag as a scoped pointer
 * recovers more of the target's offset/zero/step/flag load shape. Splitting
 * the stage-1 negative-limit path into raw and signed locals did not remove
 * the duplicate limit load, but improved the best lane by 2 bytes and 10
 * instruction diffs. Widening only the stage-2 accumulator to s32 makes the
 * object size exact and lowers the best byte_diff to 111 / diff_count 61 under
 * old_agbcc -O2 -fno-expensive-optimizations. Routing the stage-1 accumulator
 * sum through a scoped r1 local improves that lane to byte_diff 108 /
 * diff_count 47 without changing object size. Routing the stage-2 count check
 * through a scoped r1 reload improves the lane to byte_diff 106 / diff_count
 * 45, still exact-size. Restructuring stage 2 as a checked `for (;;)` loop
 * drops the best byte lane to 89 while keeping exact size; instruction diff
 * worsens, but the byte score is the stronger oracle here. Preserving the
 * raw u16 stage-2 limit for the clamp store while using its signed view for
 * comparison improves the lane to byte_diff 87 / diff_count 65. Splitting the
 * stage-1 channel base from the envelope pointer, pinning only the envelope
 * pointer to r2, and letting the compiler allocate the channel-base local
 * recovers the target's base+0x1c versus env-field access shape and improves
 * the lane to byte_diff 74 / diff_count 44. A typed
 * SlotClampEnvelope form was clearer but worsened
 * the linked score to byte_diff 124 / diff_count 85, so the reference body
 * keeps raw field accesses until the register shape is better understood;
 * casting SOUND_INLINE_CHANNEL_ENVELOPE_A_AT/SOUND_SLOT_ENVELOPE_A back to u8
 * is codegen-neutral and keeps the envelope offsets named. Negative focused
 * experiments: pinning both i/offset to r5/r7 recovered isolated target-looking
 * details but worsened the linked score; pinning the raw step to r1 collided with the r7
 * offset allocation; stage-2 raw-step splitting scored lower in bytes but
 * produced unacceptable r7 offset clobbering in the generated loop. Widening
 * the shared acc temp to s32 made the object size exact but worsened byte_diff
 * to 150; spelling the stage-1 step-sign test as a reload also made size exact
 * but lost the high-register save shape and worsened instruction diff. Stage-2
 * raw-limit splitting kept byte_diff flat but worsened instruction diff, and
 * applying fno-gcse to the stage-2 s32 accumulator shape regressed byte_diff
 * to 186. Retesting a target-looking stage-2 unsigned step/acc add after the
 * s32 accumulator improvement regressed byte_diff to 142 by moving the loop
 * index/offset allocation away from the current exact-size shape. Current
 * branch retests: widening the stage-1 accumulator to s32 regresses to
 * byte_diff 181, reloading the stage-1 step sign test regresses to 184,
 * reusing the signed negative limit store regresses to 123, moving the
 * stage-2 dirty-flag write after the accumulator update regresses to 130+,
 * and unsigned stage-2 limit-store spelling regresses to 122. Pinning the
 * stage-1 negative limit to r4 regresses to 80 by losing the high-register save
 * shape. Pinning chBase to r3 is worse than the plain local on the current
 * branch (76 vs 74). Widening the stage-1 accumulator plus explicitly
 * reloading the signed step after the accumulator store removes that truncation
 * sequence and improves the current exact-size lane to byte_diff 66 /
 * diff_count 44. Routing the stage-1 accumulator load through r0 is byte-neutral
 * but improves the instruction diff to 40 and matches the target add dataflow.
 * Splitting both stage-1 limit loads through scoped raw locals improves the byte
 * score to 63 at exact size, though the instruction diff worsens to 46. With
 * that limit shape in place, pinning the shared loop index to r5 recovers the
 * target loop-state setup and improves the lane further to byte_diff 55 /
 * diff_count 38. Shifting the stage-1 positive accumulator compare before the
 * limit load recovers the target load/shift order and improves the exact-size
 * lane to byte_diff 49 / diff_count 36. Rewriting stage-2 accumulator/clamp
 * stores through `slot + 0x1c` instead of the `env` pointer looked closer to the
 * target locally but regressed the exact-size lane to byte_diff 57 / diff_count
 * 47. A scoped r4 temp for only the stage-1 negative-limit clamp store is
 * score-neutral, so it is not kept as an extra register constraint.
 * See docs/codegen-notes.md "High registers (sl/r10, sb/r9, r8) —
 * corpus-validated unmatchable".
 */
#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_0802EC7C)
void Sound_UpdateChannelEnvelopesA(void)
{
    register SoundSystem **gpsp asm("r8");
    register SoundSystem **gpspReload asm("ip");
    SoundSystem *ss;
    register s32 i asm("r5");
    register s32 offset asm("r7");
    SoundSlot *slot;
    u8 *chBase;
    register u8 *env asm("r2"); /* points at acc field of an envelope-A block */
    u16 stepRaw;
    s16 step;
    s32 acc;
    s32 accStage2;
    u16 limitNeg;
    u16 limitRaw;
    s16 limit;
    register u16 limitPos asm("r9");

    i = 0;
    gpsp = &gpSoundSystem;
    gpspReload = gpsp;

    /* Stage 1: three inline channel envelopes embedded in SoundSystem
     * at ss+0x20..ss+0x83, stride 36, envelope at +0x1c inside each. */
    offset = SOUND_INLINE_CHANNEL_BASE_OFFSET;
    do {
        {
            register SoundSystem **gpspStage asm("r1");

            gpspStage = gpspReload;
            ss = *gpspStage;
        }
        chBase = (u8 *)ss + offset;
        env = (u8 *)SOUND_INLINE_CHANNEL_ENVELOPE_A_AT(ss, offset);
        stepRaw = SOUND_CLAMP_ENV_STEP_U16(env);
        step = (s16)stepRaw;
        if (step != 0) {
            register s32 zero asm("r6");

            {
                register s32 acc1 asm("r1");
                register u16 accRaw asm("r0");

                acc1 = stepRaw;
                accRaw = *(u16 *)(chBase + SOUND_INLINE_ENVELOPE_A_OFFSET);
                acc1 += accRaw;
                acc = acc1;
            }
            zero = 0;
            *(u16 *)(chBase + SOUND_INLINE_ENVELOPE_A_OFFSET) = acc;
            step = SOUND_CLAMP_ENV_STEP_S16(env);
            if (step > 0) {
                register s32 accCmp asm("r1");
                register u16 limitRaw0 asm("r0");

                accCmp = (s32)(s16)acc;
                accCmp <<= 16;
                limitRaw0 = SOUND_CLAMP_ENV_LIMIT_U16(env);
                limitPos = limitRaw0;
                limit = (s16)limitRaw0;
                if (accCmp > ((s32)limit << 16)) {
                    *(u16 *)(chBase + SOUND_INLINE_ENVELOPE_A_OFFSET) = limitPos;
                    SOUND_CLAMP_ENV_STEP_S16(env) = zero;
                }
            } else {
                register u16 limitNeg0 asm("r4");

                limitNeg0 = SOUND_CLAMP_ENV_LIMIT_U16(env);
                limitNeg = limitNeg0;
                limit = (s16)limitNeg0;
                if ((s32)((s32)(s16)acc << 16) < ((s32)limit << 16)) {
                    *(u16 *)(chBase + SOUND_INLINE_ENVELOPE_A_OFFSET) = limitNeg;
                    SOUND_CLAMP_ENV_STEP_S16(env) = zero;
                }
            }
            {
                u8 *flagBase = (u8 *)(*gpspReload);
                u32 flagIndex = i * SOUND_CH_FLAGS_STRIDE;
                u32 *flags;

                flagBase += SOUND_CH_FLAGS_OFFSET;
                flags = (u32 *)(flagBase + flagIndex);

                *flags |= SOUND_FLAG_ENV_DIRTY;
            }
        }
        offset += SOUND_INLINE_CHANNEL_STRIDE;
        i++;
    } while (i <= SOUND_INLINE_CHANNEL_COUNT - 1);

    /* Stage 2: per-slot envelope-A bank, walked via slotPtrTable. */
    i = 0;
    for (;;) {
        register SoundSystem **gpspStage asm("r1");

        gpspStage = gpsp;
        if (i >= (*gpspStage)->count)
            break;
        slot = SOUND_SYSTEM_SLOT_PTR_TABLE(*gpspStage)[i];
        if (slot == NULL)
            goto stage2_for_next;
        env = (u8 *)SOUND_SLOT_ENVELOPE_A(slot);
        step = SOUND_CLAMP_ENV_STEP_S16(env);
        if (step == 0)
            goto stage2_for_next;
        {
            register s32 zero asm("r6");

            slot->flags |= SOUND_FLAG_ENV_DIRTY;
            accStage2 = (s16)SOUND_CLAMP_ENV_ACC_U16(env) + step;
            zero = 0;
            SOUND_CLAMP_ENV_ACC_U16(env) = accStage2;
            if (step > 0) {
                limitRaw = SOUND_CLAMP_ENV_LIMIT_U16(env);
                limit = (s16)limitRaw;
                if ((s32)((s32)(s16)accStage2 << 16) <= ((s32)limit << 16))
                    goto stage2_for_next;
                SOUND_CLAMP_ENV_ACC_U16(env) = limitRaw;
                SOUND_CLAMP_ENV_STEP_S16(env) = zero;
            } else {
                limitRaw = SOUND_CLAMP_ENV_LIMIT_U16(env);
                limit = (s16)limitRaw;
                if ((s32)((s32)(s16)accStage2 << 16) >= ((s32)limit << 16))
                    goto stage2_for_next;
                SOUND_CLAMP_ENV_ACC_U16(env) = limitRaw;
                SOUND_CLAMP_ENV_STEP_S16(env) = zero;
            }
        }
    stage2_for_next:
        i++;
    }
}
#else
NAKED
void Sound_UpdateChannelEnvelopesA(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, r9\n"
        "    mov     r6, r8\n"
        "    push    {r6, r7}\n"
        "    movs    r5, #0\n"
        "    ldr     r0, _0802ECC4            @ =gpSoundSystem (0x030065e0)\n"
        "    mov     r8, r0\n"
        "    mov     ip, r8\n"
        "    movs    r7, #0x20\n"
        "_0802EC8E:\n"
        "    mov     r1, ip\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r3, r0, r7\n"
        "    adds    r2, r3, #0\n"
        "    adds    r2, #0x1c\n"
        "    ldrh    r1, [r2, #2]\n"
        "    movs    r4, #2\n"
        "    ldrsh   r0, [r2, r4]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802ECE8\n"
        "    ldrh    r0, [r3, #0x1c]\n"
        "    adds    r1, r1, r0\n"
        "    movs    r6, #0\n"
        "    strh    r1, [r3, #0x1c]\n"
        "    movs    r4, #2\n"
        "    ldrsh   r0, [r2, r4]\n"
        "    cmp     r0, #0\n"
        "    ble     _0802ECC8\n"
        "    lsls    r1, r1, #0x10\n"
        "    ldrh    r0, [r2, #4]\n"
        "    mov     r9, r0\n"
        "    lsls    r0, r0, #0x10\n"
        "    cmp     r1, r0\n"
        "    ble     _0802ECD6\n"
        "    mov     r1, r9\n"
        "    strh    r1, [r3, #0x1c]\n"
        "    b       _0802ECD4\n"
        "    .align  2, 0\n"
        "_0802ECC4: .4byte 0x030065e0\n"
        "_0802ECC8:\n"
        "    lsls    r1, r1, #0x10\n"
        "    ldrh    r4, [r2, #4]\n"
        "    lsls    r0, r4, #0x10\n"
        "    cmp     r1, r0\n"
        "    bge     _0802ECD6\n"
        "    strh    r4, [r3, #0x1c]\n"
        "_0802ECD4:\n"
        "    strh    r6, [r2, #2]\n"
        "_0802ECD6:\n"
        "    mov     r0, ip\n"
        "    ldr     r2, [r0, #0]\n"
        "    lsls    r0, r5, #2\n"
        "    adds    r2, #0x10\n"
        "    adds    r2, r2, r0\n"
        "    ldr     r0, [r2, #0]\n"
        "    movs    r1, #0x40\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r2, #0]\n"
        "_0802ECE8:\n"
        "    adds    r7, #0x24\n"
        "    adds    r5, #1\n"
        "    cmp     r5, #2\n"
        "    ble     _0802EC8E\n"
        "    movs    r5, #0\n"
        "    b       _0802ED46\n"
        "_0802ECF4:\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r1, [r0, #0]\n"
        "    lsls    r0, r5, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r3, [r0, #0]\n"
        "    cmp     r3, #0\n"
        "    beq     _0802ED44\n"
        "    adds    r2, r3, #0\n"
        "    adds    r2, #0x1c\n"
        "    movs    r1, #2\n"
        "    ldrsh   r0, [r2, r1]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802ED44\n"
        "    ldr     r0, [r3, #0x38]\n"
        "    movs    r1, #0x40\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r3, #0x38]\n"
        "    ldrh    r4, [r3, #0x1c]\n"
        "    ldrh    r7, [r2, #2]\n"
        "    adds    r1, r4, r7\n"
        "    movs    r6, #0\n"
        "    strh    r1, [r3, #0x1c]\n"
        "    movs    r4, #2\n"
        "    ldrsh   r0, [r2, r4]\n"
        "    cmp     r0, #0\n"
        "    ble     _0802ED36\n"
        "    lsls    r1, r1, #0x10\n"
        "    ldrh    r4, [r2, #4]\n"
        "    lsls    r0, r4, #0x10\n"
        "    cmp     r1, r0\n"
        "    ble     _0802ED44\n"
        "    b       _0802ED40\n"
        "_0802ED36:\n"
        "    lsls    r1, r1, #0x10\n"
        "    ldrh    r4, [r2, #4]\n"
        "    lsls    r0, r4, #0x10\n"
        "    cmp     r1, r0\n"
        "    bge     _0802ED44\n"
        "_0802ED40:\n"
        "    strh    r4, [r3, #0x1c]\n"
        "    strh    r6, [r2, #2]\n"
        "_0802ED44:\n"
        "    adds    r5, #1\n"
        "_0802ED46:\n"
        "    mov     r1, r8\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r5, r0\n"
        "    blt     _0802ECF4\n"
        "    pop     {r3, r4}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
