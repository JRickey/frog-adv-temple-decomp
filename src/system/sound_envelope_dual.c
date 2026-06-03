#include "sound.h"
#include "macros.h"

/* sub_0802E934 — per-frame "dual envelope" tick.
 *
 * Sister of sub_0802EC7C (sound_channel.c, envelope-A at +0x1c) and
 * sub_0802EA80 (sound_envelope.c, envelope-A0 at +0x14). Same two-stage
 * shape: stage 1 walks three inline channel blocks embedded in
 * SoundSystem itself (ss+0x20, ss+0x44, ss+0x68 — stride 36); stage 2
 * walks the per-slot bank via ss->slotPtrTable[i]. The distinguishing
 * feature: each channel/slot exposes TWO sub-envelopes back-to-back at
 * the START of the channel block (offsets +4 and +12 inside each ch_base,
 * stride 8). Each sub-envelope has the familiar 8-byte acc/step/limit
 * shape.
 *
 * Bounce semantics differ from sub_0802EC7C: instead of clamping to the
 * limit and zeroing step, the wrap subtracts the unsigned u16 form of
 * the limit from the accumulator — a true sawtooth wrap. step is
 * preserved across the wrap. dirty bit 0x40 is ORd into ss->chFlags[i]
 * (stage 1) or slot->flags (stage 2) unconditionally whenever step is
 * non-zero.
 *
 *   if step != 0:
 *       acc = (u16)(acc + step)
 *       if limit > 0 && (s16)acc > limit:  acc -= (u16)limit
 *       if limit < 0 && (s16)acc < limit:  acc -= (u16)limit
 *       (limit == 0 has its own bge path that effectively no-ops)
 *       chFlags[i] |= 0x40   /  slot->flags |= 0x40
 *
 * Shipped as NAKED inline asm + a NON_MATCHING reference C body. The
 * baserom pins THREE values into Thumb high registers as loop state:
 *   sl  =  &gpSoundSystem        (alive across stage 2 count check)
 *   r9  =  sl  (mirror, used by stage-1 inner reload)
 *   r8  =  ch_base offset i*36+32
 *   ip  =  i*4 (chFlags byte stride)
 * Pinning the channel-base offset to r8, shaping the halfword sum / signed
 * limit flow, making the gpSoundSystem sl/r9 mirror explicit, zeroing
 * the stage-1 loop index before loading gpSoundSystem, and carrying the next
 * stage-1 index through an ordinary local got the earlier isolated C candidate
 * to byte_diff 162 / diff_count 49. Routing the stage-1 reloads through
 * scoped r1 pointers, shaping the stage-2 slot reload the same way, spelling
 * stage 2 as a bottom-tested loop, splitting the stage-2 step into an
 * unsigned add input plus signed test value, and moving the stage-1 next-index
 * assignment after the channel-base calculation makes the forced-C lane
 * size-exact. Indexing the stage-2 dual-env pair directly through
 * SOUND_SLOT_DUAL_ENV(slot) as a pointer walk improves the current forced-C
 * lane to byte_diff 74 / insn_diff 52 with agbcc -O2 -fforce-addr -fno-gcse.
 * Mirroring the unsigned-step add order in both stages improves that lane to
 * byte_diff 72 / insn_diff 50. Restructuring stage 2 as a checked `for (;;)`
     * loop instead of a bottom-tested goto loop opens a much better exact-size
     * forced-C agbcc plain-O2 lane at byte_diff 45 / insn_diff 34. The linked
     * default object still needs its Makefile flags because sibling exact helpers
     * in this translation unit are part of the ROM-matching path. The main
     * remaining mismatch is the stage-1 outer loop register assignment: agbcc
     * keeps the loop index in r5, while the target keeps it in r2/r7/r8/ip.
 * Pinning the stage-1 envelope offset
 * to r5 is byte-neutral and trims one instruction diff. The readable C is
 * preserved behind NON_MATCHING for the phase-3 PC port; the NAKED form ships
 * the baserom bytes.
 *
 * Negative experiments: pinning i/next/flagOff to r2/r7/ip, pinning env to r2,
 * or rewriting the channel-offset expression to force recomputation all
 * regressed the linked byte score. A scoped r7/r5/ip stage-1 shape improved
 * the byte score by one but made agbcc emit a bad `cmp sp, #2` loop test, so it
 * is intentionally not kept. Pinning only the stage-2 next-slot index to r7
 * improved byte_diff 166 -> 164 but produced `cmp sp, r0` at the stage-2 count
 * check, so that is also not kept.
 * An ordinary stage-1 flag-offset local shortened the dirty-flag store but
 * regressed byte_diff to 179 by moving away from the target's add-0x10 shape.
 * Retesting an r2 pin for the loop index after the bottom-tested rewrite still
 * regressed badly, so the ordinary local remains. Pinning the stage-2 slot
 * pointer to r5 matched one target register but grew the object to 254 bytes;
 * spelling a stage-2 next-index local likewise grew the object to 250 bytes.
 * Pinning the stage-1 next-index local to r7 matched one target instruction
 * momentarily, but immediately clobbered it with the envelope offset and
 * regressed byte_diff to 132. Retesting a scoped stage-1 dirty-flag pointer
 * in r0 on the current split source removed the duplicate-looking address
 * expression locally but regressed byte_diff to 149. Current branch retests:
 * a for-loop stage 1 introduces a stack frame and regresses to 188; moving
 * nextI before chBaseOff regresses to 83; u32 i regresses to 83; s16 i and
 * stage-2 slot pinning introduce stack frames; stage-1 stepRaw splitting
 * regresses to 84; signed-only limit forms regress to 87+; and unpinning limit
 * regresses to 98. Combining the reversed stage-2 add with nearby neutral and
 * negative stage-1/stage-2 spellings did not find a cleaner same-byte or
 * lower-byte lane. Current target-register probes show the same pattern:
 * pinning i/nextI/envOff or spelling the stage-1 flag offset as an ip local
 * improves isolated details but introduces stack frames, grows the object, or
 * worsens instruction alignment. Current temporary variant sweep: a stage-1
     * channel-base local is neutral at 72, a stage-1 countdown loop regresses to
     * 73, `i` as u32 regresses to 74, and raw dirty-flag address spelling
     * regresses to 180. After the stage-2 loop improvement, pinning nextI to r7
     * regresses to 103, moving nextI before the channel-base calculation regresses
     * to 47, and an unused flag-offset pressure local is neutral at 45. A typed
     * SoundInlineChannel base for the stage-1 envelope owner is also codegen-neutral
     * at byte_diff 45 / diff_count 34, so the reference body keeps that structure.
     * Retesting the raw chFlags offset through a helper on the current branch
     * regresses the exact-size lane to byte_diff 176 by shrinking the object.
     */

/* The +4/+12 sub-envelope pair. Both sub-envelopes share this shape. */
#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_0802E934)
void sub_0802E934(void)
{
    SoundSystem *ss;
    register SoundSystem **gpsp asm("sl");
    register SoundSystem **gpspStage asm("r9");
    SoundSlot *slot;
    DualSubEnv *env;
    SoundInlineChannel *ch;
    s32 i;
    s32 j;
    s32 nextI;
    register s32 chBaseOff asm("r8");
    register s32 envOff asm("r5");
    u16 stepRaw;
    s16 step;
    s32 acc;
    register s32 limit asm("r3");
    u16 limitU;

    /* Stage 1: three inline channel envelopes embedded in SoundSystem
     * at ss+0x20, ss+0x44, ss+0x68 (stride 36). Each channel block has
     * two sub-envelopes at +4 and +12 inside it. */
    i = 0;
    gpsp = &gpSoundSystem;
    gpspStage = gpsp;
    do {
        chBaseOff = i * SOUND_INLINE_CHANNEL_STRIDE + SOUND_INLINE_CHANNEL_BASE_OFFSET;
        nextI = i + 1;
        envOff = SOUND_DUAL_ENV_FIRST_OFFSET;
        for (j = 0; j <= SOUND_DUAL_ENV_COUNT - 1; j++) {
            {
                register SoundSystem **gpspReload asm("r1");

                gpspReload = gpspStage;
                ss = *gpspReload;
            }
            ch = (SoundInlineChannel *)((u8 *)ss + chBaseOff);
            env = SOUND_INLINE_CHANNEL_DUAL_ENV_AT(ch, 0, envOff);
            stepRaw = env->step;
            step = (s16)stepRaw;
            if (step != 0) {
                acc = stepRaw + env->acc;
                env->acc = acc;
                limitU = env->limit;
                limit = (s16)limitU;
                if (limit > 0) {
                    if ((s16)acc > limit)
                        env->acc = (u16)(acc - limitU);
                } else {
                    if ((s16)acc < limit)
                        env->acc = (u16)(acc - limitU);
                }
                {
                    register SoundSystem **gpspReload asm("r1");

                    gpspReload = gpspStage;
                    (*gpspReload)->chFlags[i] |= SOUND_FLAG_ENV_DIRTY;
                }
            }
            envOff += SOUND_DUAL_ENV_STRIDE;
        }
        i = nextI;
    } while (i <= SOUND_INLINE_CHANNEL_COUNT - 1);

    /* Stage 2: per-slot dual envelope bank, walked via slotPtrTable. */
    i = 0;
    for (;;) {
        {
            register SoundSystem **gpspReload asm("r1");

            gpspReload = gpsp;
            if (i >= (*gpspReload)->count)
                break;
            slot = SOUND_SYSTEM_SLOT_PTR_TABLE(*gpspReload)[i];
        }
        if (slot != NULL) {
            env = SOUND_SLOT_DUAL_ENV(slot);
            for (j = 0; j <= SOUND_DUAL_ENV_COUNT - 1; j++) {
                stepRaw = env->step;
                step = (s16)stepRaw;
                if (step != 0) {
                    acc = stepRaw + env->acc;
                    env->acc = acc;
                    limitU = env->limit;
                    limit = (s16)limitU;
                    if (limit > 0) {
                        if ((s16)acc > limit)
                            env->acc = (u16)(acc - limitU);
                    } else {
                        if ((s16)acc < limit)
                            env->acc = (u16)(acc - limitU);
                    }
                    slot->flags |= SOUND_FLAG_ENV_DIRTY;
                }
                env++;
            }
        }
        i++;
    }
}
#else
NAKED
void sub_0802E934(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    movs    r2, #0\n"
        "    ldr     r0, _0802E988            @ =gpSoundSystem (0x030065e0)\n"
        "    mov     sl, r0\n"
        "    mov     r9, sl\n"
        "_0802E946:\n"
        "    lsls    r0, r2, #3\n"
        "    adds    r7, r2, #1\n"
        "    adds    r0, r0, r2\n"
        "    lsls    r0, r0, #2\n"
        "    adds    r0, #0x20\n"
        "    mov     r8, r0\n"
        "    movs    r5, #4\n"
        "    lsls    r2, r2, #2\n"
        "    mov     ip, r2\n"
        "    movs    r6, #1\n"
        "_0802E95A:\n"
        "    mov     r1, r9\n"
        "    ldr     r0, [r1, #0]\n"
        "    add     r0, r8\n"
        "    adds    r2, r0, r5\n"
        "    ldrh    r1, [r2, #2]\n"
        "    movs    r3, #2\n"
        "    ldrsh   r0, [r2, r3]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802E9A8\n"
        "    ldrh    r0, [r2, #0]\n"
        "    adds    r1, r1, r0\n"
        "    strh    r1, [r2, #0]\n"
        "    ldrh    r4, [r2, #4]\n"
        "    movs    r0, #4\n"
        "    ldrsh   r3, [r2, r0]\n"
        "    cmp     r3, #0\n"
        "    ble     _0802E98C\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    ble     _0802E998\n"
        "    b       _0802E994\n"
        "    .align  2, 0\n"
        "_0802E988: .4byte 0x030065e0\n"
        "_0802E98C:\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    bge     _0802E998\n"
        "_0802E994:\n"
        "    subs    r0, r1, r4\n"
        "    strh    r0, [r2, #0]\n"
        "_0802E998:\n"
        "    mov     r1, r9\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0x10\n"
        "    add     r0, ip\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r2, #0x40\n"
        "    orrs    r1, r2\n"
        "    str     r1, [r0, #0]\n"
        "_0802E9A8:\n"
        "    adds    r5, #8\n"
        "    subs    r6, #1\n"
        "    cmp     r6, #0\n"
        "    bge     _0802E95A\n"
        "    adds    r2, r7, #0\n"
        "    cmp     r2, #2\n"
        "    ble     _0802E946\n"
        "    movs    r2, #0\n"
        "    b       _0802EA12\n"
        "_0802E9BA:\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r1, [r0, #0]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r5, [r0, #0]\n"
        "    adds    r7, r2, #1\n"
        "    cmp     r5, #0\n"
        "    beq     _0802EA10\n"
        "    adds    r2, r5, #4\n"
        "    movs    r6, #1\n"
        "_0802E9D0:\n"
        "    ldrh    r1, [r2, #2]\n"
        "    movs    r3, #2\n"
        "    ldrsh   r0, [r2, r3]\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EA08\n"
        "    ldrh    r0, [r2, #0]\n"
        "    adds    r1, r1, r0\n"
        "    strh    r1, [r2, #0]\n"
        "    ldrh    r4, [r2, #4]\n"
        "    movs    r0, #4\n"
        "    ldrsh   r3, [r2, r0]\n"
        "    cmp     r3, #0\n"
        "    ble     _0802E9F4\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    ble     _0802EA00\n"
        "    b       _0802E9FC\n"
        "_0802E9F4:\n"
        "    lsls    r0, r1, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    cmp     r0, r3\n"
        "    bge     _0802EA00\n"
        "_0802E9FC:\n"
        "    subs    r0, r1, r4\n"
        "    strh    r0, [r2, #0]\n"
        "_0802EA00:\n"
        "    ldr     r0, [r5, #0x38]\n"
        "    movs    r1, #0x40\n"
        "    orrs    r0, r1\n"
        "    str     r0, [r5, #0x38]\n"
        "_0802EA08:\n"
        "    adds    r2, #8\n"
        "    subs    r6, #1\n"
        "    cmp     r6, #0\n"
        "    bge     _0802E9D0\n"
        "_0802EA10:\n"
        "    adds    r2, r7, #0\n"
        "_0802EA12:\n"
        "    mov     r1, sl\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r2, r0\n"
        "    blt     _0802E9BA\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .hword  0x0000\n"
        "    .syntax divided\n");
}
#endif

void sub_0802EA2C(s32 step, u32 reload, s32 ch)
{
    if (ch <= 2) {
        u8 *base;
        register s32 off asm("r1");
        u32 half;

        base = (u8 *)gpSoundSystem;
        off = ch * SOUND_INLINE_CHANNEL_STRIDE;
        SOUND_INLINE_ENVELOPE_A0_AT(base, off)->reload = reload;
        base = (u8 *)gpSoundSystem + off;
        half = reload >> 1;
        SOUND_INLINE_ENVELOPE_A0_AT(base, 0)->countdown = half;
        SOUND_INLINE_ENVELOPE_A0_AT(gpSoundSystem, off)->step = step;
        return;
    }

    if (ch <= 3)
        return;

    {
        u8 **bankp = (u8 **)((u8 *)gpSoundSystem + SOUND_SYSTEM_SW_SLOTS_OFFSET);
        SlotEnvelopeA0 *env;

        env = (SlotEnvelopeA0 *)(ch * SOUND_SW_SLOT_STRIDE + (s32)*bankp - SOUND_SW_SLOT_ENVELOPE_A0_BIAS);
        env->reload = reload;
        env->countdown = reload >> 1;
        env->step = step;
    }
}
