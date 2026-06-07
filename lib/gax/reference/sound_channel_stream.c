#include "sound.h"
#include "macros.h"

/* Sound_TickStreamHead — per-frame stream-cursor advancer.
 *
 * Iterates `gpSoundSystem->count` slots. For each slot that is (a) active
 * (flag 0x800), (b) has a non-NULL SoundStream in `(*gpSoundSystem)->
 * streamTable[i]`, and (c) has elapsed its per-frame countdown, advances
 * the stream's cursor (`head`) by the signed envelope `acc`. The
 * remaining-frames counter at slot+0x30 ticks down; when it hits zero,
 * either flips into a bounce (flag 0x4000 → reload limit from step and
 * negate acc) or clears flags 0x4800.
 *
 * Shipped as NAKED inline asm + a NON_MATCHING reference C body.
 * The baserom pins `&gpSoundSystem` into the Thumb high register `sl`
 * (r10) to keep it live across the b.n into the shared count-check at
 * the loop tail. Corpus-validated unmatchable in agbcc 2.x — see
 * docs/codegen-notes.md "High registers (sl/r10, sb/r9, r8) —
 * corpus-validated unmatchable".
 *
 * History: c. May 2026 — permuter and multi-pin register variants were
 * not close enough to ship. After splitting this function into its own
 * translation unit, keeping the original stream head in ip, splitting the
 * loop-body SoundSystem reload into r4 while keeping a separate r0 count-check
 * reload, pinning the stream-table base temp to r0, and replacing the raw +4
 * halfword casts with the shared SOUND_SLOT_STREAM_ENVELOPE view moved the candidate
 * to byte_diff 217 / diff_count 77. Spelling the initial `gpSoundSystem` load
 * through a scoped r1 pointer, then using a scoped r1 index for the first slot
 * table access, got the candidate to byte_diff 199 / diff_count 84. Pinning
 * the stream head snapshot (`oldHead`) to r1 recovers a little more of the
 * active-block dataflow, then pinning the remaining-frame count to r6 after
 * that dataflow settled, recovers a little more of the target's active-block
 * register shape. The current best non-fixed-register byte lane is byte_diff
 * 194 / diff_count 87 with old_agbcc -O1, while old_agbcc -O2 is the
 * better-shaped 196 / 82 lane. Object-level scores remain useful only for
 * sorting experiments.
 *
 * Negative experiments: pinning slot to r2, i to r9, or gpSoundSystem to r1
 * regressed. Pinning the overflow flag to r8 improved byte diff but displaced
 * the loop index into sl and worsened instruction alignment. Pinning stream
 * head to r1 only improved an O1 byte score by moving the stream pointer to
 * r8, away from the target's r7. Removing the r0 SoundSystem reload pin
 * lowered instruction diff but regressed byte_diff 234 -> 235; pinning gpsp
 * directly to sl dropped the target's preflight load and regressed again
 * after the r4/r0 split. Raw limitPair halfword casts were codegen-neutral and
 * kept the bad r8 pointer lifetime, so the typed field form is retained.
 * Earlier `remaining`-to-r6 probes regressed before the stream-head r1 shape
 * landed, but the current source shape benefits from it. Pinning the stream
 * pointer to r7 or the overflow flag to r8 still regresses badly.
 * Replacing the explicit `ss + 0xc4` stream-table load with
 * SOUND_SYSTEM_STREAM_TABLE was clearer but moved the table-base load shape
 * away from the target and regressed byte_diff to 219. Delaying the active
 * block's `wrapSpan` load into each branch, inverting the head-vs-wrapThreshold branch
 * order, or caching wrapThreshold in a separate local all looked closer to the target
 * comparison block but regressed byte_diff to 203+ by displacing the prologue
 * and stream-pointer register shape. Retesting the inverted branch on the
 * current split source regressed to byte_diff 228+ and introduced a stack
 * frame. Loading stream->sub before computing the cursor likewise regressed
 * the best O1 byte lane to 199. Introducing a shared `i << 2` table-offset
 * local in r3 for both slot and stream table accesses looked target-like but
 * shortened the object and regressed the best O1 byte lane to 223. Keeping
 * that r3 table offset only for the stream table matches the target's second
 * table access and improves the current forced-C lane. Spelling the stream
 * clear-mask as a local trims the current best lane to byte_diff 186 /
 * diff_count 83. Keeping the stream-table address calculation in a scoped r0
 * temp improves it slightly to byte_diff 185 / diff_count 82. Expanding the
 * compiler-flag matrix found old_agbcc -O2
 * -fforce-addr -fno-gcse -fno-cse-follow-jumps as the current best lane.
 * Current-branch source probes: caching wrapThreshold introduces a stack frame and
 * regresses to byte_diff 252; pinning the stream pointer to r7 regresses to
 * 254; removing the ip head or r1 oldHead pins regresses; removing the r6
 * remaining pin regresses to 196; removing the r3 envelope pin regresses to
 * 231; SOUND_SYSTEM_STREAM_TABLE still regresses, now to 212; bounce-flag
 * local spelling regresses to 196, while overflow type, literal clear mask,
 * countdown decrement spelling, countdown reload temp, wrapThreshold local
 * spelling, and a remaining-count reload temp are neutral. Retesting the r3
 * table-offset spelling only for the first slot table lookup still regresses to
 * byte_diff 223 by shrinking the object and perturbing the stream pointer shape.
 * Spelling the bounce-flag test through a scoped flags word in r1 and mask in r0
 * improves the current exact-size lane to byte_diff 182 / diff_count 79. Typing
 * stream->sub as a SoundStreamSub and spelling the loop base as `sub + 1` is
 * codegen-neutral while documenting the +0x10 loop-data header. A diagnostic
 * -ffixed-r3 lane scores byte_diff 180 but shrinks the object to 254/262 and
 * removes a target-used register, so it is not a landable flag.
 */
#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_0802EDF0)
void Sound_TickStreamHead(void)
{
    SoundSystem **gpsp;
    register SoundSystem *ss asm("r4");
    register SoundSystem *ssCount asm("r0");
    SoundSlot *slot;
    SoundStream *stream;
    register StreamSlotEnvelope *env asm("r3");
    register u16 remaining asm("r6");
    register u32 head asm("ip");
    u32 cursor;
    s32 i;
    s32 overflow;
    SoundStreamSub *sub;
    u32 sub16;

    i = 0;
    {
        register SoundSystem **gpspInit asm("r1");

        gpspInit = &gpSoundSystem;
        ssCount = *gpspInit;
        gpsp = gpspInit;
    }
    goto loop_count_check;

loop_body:
    ss = *gpsp;
    {
        register s32 index asm("r1");

        index = i;
        slot = SOUND_SYSTEM_SLOT_PTR_TABLE(ss)[index];
    }
    if (slot == NULL)
        goto next;
    if (!(slot->flags & SOUND_SLOT_FLAG_STREAM_ACTIVE))
        goto next;
    {
        register s32 tableOff asm("r3");
        register u8 *streamBase asm("r0");
        register u32 streamAddr asm("r0");

        tableOff = i << 2;
        streamBase = (u8 *)ss;
        streamBase += SOUND_SYSTEM_STREAM_TABLE_OFFSET;
        streamAddr = tableOff + (u32) * (void **)streamBase;
        stream = *(SoundStream **)streamAddr;
    }
    if (stream == NULL)
        goto next;
    env = SOUND_SLOT_STREAM_ENVELOPE(slot);
    if (env->frameCountdown != 0)
        goto dec_countdown;
    env->frameCountdown = env->frameReload;
    remaining = env->limitPair;
    if (remaining != 0)
        goto active_block;
    {
        register u32 flagsWord asm("r1");
        register u32 bounceMask asm("r0");

        flagsWord = slot->flags;
        bounceMask = SOUND_SLOT_FLAG_STREAM_BOUNCE;
        bounceMask &= flagsWord;
        if (bounceMask != 0) {
            env->limitPair = env->step;
            {
                u16 accVal = SOUND_SLOT_STREAM_ACC_U16(slot);
                SOUND_SLOT_STREAM_ACC_U16(slot) = (u16) - (s16)accVal;
            }
        } else {
            u32 clearMask = SOUND_SLOT_FLAG_STREAM_CLEAR;

            slot->flags &= clearMask;
        }
    }
    remaining = env->limitPair;
    if (remaining == 0)
        goto next;

active_block: {
    s16 accS = env->acc;
    register u32 oldHead asm("r1");
    u32 wrapSpan;

    oldHead = stream->head;
    cursor = oldHead + (u32)(s32)accS;
    overflow = 0;
    sub = stream->sub;
    sub16 = (u32)(sub + 1);
    wrapSpan = stream->wrapSpan;
    head = oldHead;
    if (head > stream->wrapThreshold) {
        u32 t = cursor - wrapSpan;
        if (t < sub16)
            goto set_overflow;
        {
            u32 top = sub16 + sub->loopLength;
            if (cursor <= top)
                goto check_overflow;
        }
    set_overflow:
        overflow = 1;
    } else {
        if (cursor < sub16)
            goto do_bounce;
        {
            u32 sum = cursor + wrapSpan;
            u32 top = sub16 + sub->loopLength;
            if (sum <= top)
                goto check_overflow;
        }
        goto do_bounce;
    }
check_overflow:
    if (overflow != 0)
        goto do_bounce;
    env->limitPair = remaining - 1;
    goto store_head;
do_bounce:
    cursor = head;
    env->step = (s16)(env->step - (s16)remaining);
    env->limitPair = 0;
store_head:
    stream->head = cursor;
}
    goto next;
dec_countdown:
    env->frameCountdown--;
next:
    i++;
    ssCount = *gpsp;
loop_count_check:
    if (i < ssCount->count)
        goto loop_body;
}
#else
NAKED
void Sound_TickStreamHead(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    movs    r0, #0\n"
        "    mov     r9, r0\n"
        "    ldr     r1, _0802EE08            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r1, #0]\n"
        "    mov     sl, r1\n"
        "    b       _0802EEE4\n"
        "    .align  2, 0\n"
        "_0802EE08: .4byte 0x030065e0\n"
        "_0802EE0C:\n"
        "    ldr     r4, [r1, #0]\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #0xcc\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     r1, r9\n"
        "    lsls    r3, r1, #2\n"
        "    adds    r0, r3, r0\n"
        "    ldr     r2, [r0, #0]\n"
        "    cmp     r2, #0\n"
        "    beq     _0802EEDC\n"
        "    ldr     r0, [r2, #0x38]\n"
        "    movs    r1, #0x80\n"
        "    lsls    r1, r1, #4\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EEDC\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #0xc4\n"
        "    ldr     r0, [r0, #0]\n"
        "    adds    r0, r3, r0\n"
        "    ldr     r7, [r0, #0]\n"
        "    cmp     r7, #0\n"
        "    beq     _0802EEDC\n"
        "    adds    r3, r2, #0\n"
        "    adds    r3, #0x2c\n"
        "    ldrb    r0, [r3, #7]\n"
        "    cmp     r0, #0\n"
        "    bne     _0802EED8\n"
        "    ldrb    r0, [r3, #6]\n"
        "    strb    r0, [r3, #7]\n"
        "    ldrh    r0, [r3, #4]\n"
        "    adds    r6, r0, #0\n"
        "    cmp     r6, #0\n"
        "    bne     _0802EE76\n"
        "    ldr     r1, [r2, #0x38]\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #7\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EE68\n"
        "    ldrh    r0, [r3, #2]\n"
        "    strh    r0, [r3, #4]\n"
        "    ldrh    r1, [r2, #0x2c]\n"
        "    negs    r0, r1\n"
        "    strh    r0, [r2, #0x2c]\n"
        "    b       _0802EE6E\n"
        "_0802EE68:\n"
        "    ldr     r0, _0802EEA4            @ =0xffffb7ff\n"
        "    ands    r1, r0\n"
        "    str     r1, [r2, #0x38]\n"
        "_0802EE6E:\n"
        "    ldrh    r0, [r3, #4]\n"
        "    adds    r6, r0, #0\n"
        "    cmp     r6, #0\n"
        "    beq     _0802EEDC\n"
        "_0802EE76:\n"
        "    movs    r1, #0\n"
        "    ldrsh   r0, [r3, r1]\n"
        "    ldr     r1, [r7, #0xc]\n"
        "    adds    r5, r1, r0\n"
        "    movs    r0, #0\n"
        "    mov     r8, r0\n"
        "    ldr     r4, [r7, #0]\n"
        "    adds    r2, r4, #0\n"
        "    adds    r2, #0x10\n"
        "    ldr     r0, [r7, #8]\n"
        "    mov     ip, r1\n"
        "    cmp     ip, r0\n"
        "    bhi     _0802EEA8\n"
        "    cmp     r5, r2\n"
        "    bcc     _0802EEC2\n"
        "    ldr     r1, [r7, #0x10]\n"
        "    adds    r1, r5, r1\n"
        "    ldr     r0, [r4, #0]\n"
        "    adds    r0, r2, r0\n"
        "    cmp     r1, r0\n"
        "    bls     _0802EEBC\n"
        "    b       _0802EEC2\n"
        "    .align  2, 0\n"
        "_0802EEA4: .4byte 0xffffb7ff\n"
        "_0802EEA8:\n"
        "    ldr     r0, [r7, #0x10]\n"
        "    subs    r0, r5, r0\n"
        "    cmp     r0, r2\n"
        "    bcc     _0802EEB8\n"
        "    ldr     r0, [r4, #0]\n"
        "    adds    r0, r2, r0\n"
        "    cmp     r5, r0\n"
        "    bls     _0802EEBC\n"
        "_0802EEB8:\n"
        "    movs    r1, #1\n"
        "    mov     r8, r1\n"
        "_0802EEBC:\n"
        "    mov     r0, r8\n"
        "    cmp     r0, #0\n"
        "    beq     _0802EED0\n"
        "_0802EEC2:\n"
        "    mov     r5, ip\n"
        "    ldrh    r1, [r3, #2]\n"
        "    subs    r0, r1, r6\n"
        "    movs    r1, #0\n"
        "    strh    r0, [r3, #2]\n"
        "    strh    r1, [r3, #4]\n"
        "    b       _0802EED4\n"
        "_0802EED0:\n"
        "    subs    r0, r6, #1\n"
        "    strh    r0, [r3, #4]\n"
        "_0802EED4:\n"
        "    str     r5, [r7, #0xc]\n"
        "    b       _0802EEDC\n"
        "_0802EED8:\n"
        "    subs    r0, #1\n"
        "    strb    r0, [r3, #7]\n"
        "_0802EEDC:\n"
        "    movs    r0, #1\n"
        "    add     r9, r0\n"
        "    mov     r1, sl\n"
        "    ldr     r0, [r1, #0]\n"
        "_0802EEE4:\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r9, r0\n"
        "    blt     _0802EE0C\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif

/* SoundChannel_SetEnvelopeC — kick off envelope-C on a channel.
 *
 * Resets the envelope-C state bits in the channel's flags word (clearing
 * the active bit, the 2-bit mode field and the inactive bit), then re-arms
 * envelope-C: ACTIVE plus, when `setMode` is non-zero, the kickoff mode bit
 * (0x8 == SOUND_ENVELOPE_C_MODE_KICKOFF << 1). The per-channel envelope-C
 * accumulator is zeroed and the supplied config pointer is stored.
 *
 * Channels 0..3 are the inline/direct channels: the flags live in
 * ss->chFlags[channel] and the envelope-C block in ss->channels[channel].
 * Channels >= 4 are the software-mixed slots reached through
 * SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL, with flags at slot+0x38 and the
 * envelope-C block at slot+0x24.
 */
void SoundChannel_SetEnvelopeC(EnvelopeCConfig *cfg, u8 setMode, s32 channel)
{
    SoundSystem *ss;
    SoundSlot *slot;
    EnvelopeCBlock *block;
    u32 flags;
    u32 kickoff;
    EnvelopeCConfig **paramBase;

    if (channel > 3)
        goto sw_slot;

    ss = gpSoundSystem;
    {
        /* A path-local flags value (distinct from the sw-slot `flags`)
         * colours to r1 here, leaving r3 for the &chFlags[channel]
         * address temp — the baserom's inline-channel register shape. */
        u32 chFlags;

        chFlags = ss->chFlags[channel];
        chFlags &= ~(SOUND_ENVELOPE_C_MODE_BITS | SOUND_FLAG_ENVELOPE_C_INACTIVE);
        ss->chFlags[channel] = chFlags;
        kickoff = (SOUND_ENVELOPE_C_MODE_KICKOFF << 1) | SOUND_FLAG_ENVELOPE_C_ACTIVE;
        if (setMode == 0)
            kickoff = SOUND_FLAG_ENVELOPE_C_ACTIVE;
        chFlags |= kickoff;
        ss->chFlags[channel] = chFlags;
    }
    /* acc (+0x90) and param (+0x8c) are the same envelope-C block, but the
     * baserom addresses them through two separate ss-relative bases; a
     * distinct paramBase pointer keeps agbcc from CSE-folding them into one. */
    *(u16 *)((u8 *)ss + (channel << 3) + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = 0;
    paramBase = (EnvelopeCConfig **)((u8 *)ss + SOUND_ENVELOPE_C_CHANNEL_BASE);
    *(EnvelopeCConfig **)((u8 *)paramBase + (channel << 3)) = cfg;
    return;

sw_slot:
    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, channel);
    flags = slot->flags;
    flags &= ~(SOUND_ENVELOPE_C_MODE_BITS | SOUND_FLAG_ENVELOPE_C_INACTIVE);
    slot->flags = flags;
    kickoff = (SOUND_ENVELOPE_C_MODE_KICKOFF << 1) | SOUND_FLAG_ENVELOPE_C_ACTIVE;
    if (setMode == 0)
        kickoff = SOUND_FLAG_ENVELOPE_C_ACTIVE;
    flags |= kickoff;
    slot->flags = flags;
    block = SOUND_SLOT_ENVELOPE_C(slot);
    block->acc = 0;
    block->param.cfg = cfg;
}

void Sound_ApplyEnvelopeC(u8 clearAcc, u16 value, s32 channel)
{
    register u32 cf asm("r2");           /* keeps the first inline flag offset in r2 for the flag load */
    register u32 cfReload asm("ip");     /* preserves the later flags update as `[r2, ip]` */
    register SoundSystem **pp asm("r3"); /* materializes `&gpSoundSystem` in r3 before the first ss load */
    SoundSystem **ppReload;              /* keeps the gp pointer live across the inline inactive path */
    SoundSystem **ppFinal;               /* forces the final inline accumulator reload through r1 */
    SoundSystem *ss1;
    SoundSystem *ss2; /* keeps the second SoundSystem reload in r3 for the param store */
    SoundSystem *ss3;
    SoundSlot *slot;
    u32 flags;
    register u32 newFlags asm("r0"); /* keeps the updated flags value in r0 through mask/or/store */
    register s16 accReset asm("r1"); /* matches the inline channel accumulator reset stores */
    s32 channelOffset;

    if (channel > 3)
        goto sw_slot;

    pp = &gpSoundSystem;
    ss1 = *pp;
    cf = (u32)(channel << 2);
    {
        u8 *flagp;

        flagp = (u8 *)ss1;
        flagp += SOUND_CH_FLAGS_OFFSET;
        flagp += cf;
        flags = *(u32 *)flagp;
    }
    flags &= SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    ppReload = pp;
    cfReload = cf;
    channelOffset = channel << 3;
    if (flags == 0) {
        u8 *accp;

        accp = (u8 *)ss1 + channelOffset;
        accReset = 0;
        if (clearAcc == 0) {
            cf = 0xff;
            cf <<= 8;
            accReset = cf;
        }
        *(u16 *)(accp + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    }

    ss2 = *ppReload;
    {
        register u32 *flagp asm("r2"); /* anchors the second inline flags address in r2 */

        flagp = (u32 *)((u8 *)ss2 + SOUND_CH_FLAGS_OFFSET);
        flagp = (u32 *)((u8 *)flagp + cfReload);
        newFlags = *flagp;
        newFlags &= SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE;
        newFlags |= SOUND_FLAG_ENVELOPE_C_INACTIVE;
        *flagp = newFlags;
    }
    ss2 = (SoundSystem *)((u8 *)ss2 + SOUND_ENVELOPE_C_CHANNEL_BASE);
    ss2 = (SoundSystem *)((u8 *)ss2 + channelOffset);
    *(s32 *)ss2 = value;
    if (clearAcc == 0)
        *(s32 *)ss2 = -(s32)value;

    ppFinal = ppReload;
    ss3 = *ppFinal;
    {
        u8 *accp;

        accp = (u8 *)ss3 + channelOffset;
        accReset = 0;
        if (clearAcc == 0) {
            cf = 0xff;
            cf <<= 8;
            accReset = cf;
        }
        *(u16 *)(accp + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    }
    return;

sw_slot:
    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, channel);
    newFlags = slot->flags;
    flags = SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    newFlags &= flags;
    if (newFlags == 0) {
        register s16 accReset asm("r0"); /* keeps the sw-slot accumulator reset value in r0 */
        register u32 high asm("r1");     /* builds 0xff00 in r1 before copying to r0 */

        accReset = 0;
        if (clearAcc == 0) {
            high = 0xff;
            high <<= 8;
            accReset += high;
        }
        SOUND_SLOT_ENVELOPE_C(slot)->acc = accReset;
    }

    newFlags = slot->flags;
    newFlags &= SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE;
    newFlags |= SOUND_FLAG_ENVELOPE_C_INACTIVE;
    slot->flags = newFlags;
    SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = value;
    if (clearAcc == 0)
        SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = -(s32)value;
}
