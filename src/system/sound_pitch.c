#include "macros.h"
#include "sound.h"

/* Sound_EmitPsgPitch — per-tone-channel pitch / frequency setter.
 *
 * Called from the per-VBlank mixer (SoundMixer_VBlankUpdate) once per active
 * "fade-request" slot, for each of the three programmable-frequency
 * PSG channels (square1, square2, wave). Channel 3 (noise) goes
 * through a separate path and is filtered out here by the cmp ch, #2.
 *
 * Inputs are split from a 16-bit mixer accumulator by the caller:
 *   x  = high byte of the accumulator, used as a semitone-style integer
 *        key (modulo 84 — 7 octaves of 12 semitones).
 *   y  = signed low byte of the accumulator, used as a 1/255 fractional
 *        offset between adjacent LUT entries.
 *   ch = channel index (0..2).
 *
 * Algorithm:
 *   1. Wrap x into [0, 83] by +/-84 — a single octave-mod into the
 *      PSG-rate LUT.
 *   2. If y == 0, take freq = sPsgPitchLut[x + 1] verbatim. Otherwise
 *      linearly interpolate the bracket pair sPsgPitchLut[x + 1] and
 *      sPsgPitchLut[x + 2] by y / 255 (signed divide via __divsi3).
 *   3. Cache the resulting freq u16 at gpSoundSystem->pitchCache[ch].
 *      If unchanged from the previous tick, skip the MMIO write.
 *   4. Write freq to the channel's frequency-control MMIO register,
 *      preserving bit 14 (length-enable) of the existing register
 *      value. Bit 15 (initial/start) is cleared by the write — the
 *      channel keeps playing without retriggering.
 *
 * Companion to SoundVolume_Emit in sound_volume.c (volume setter, called
 * for the same channels by the same mixer dispatch).
 *
 * Shipped as NAKED inline asm + a NON_MATCHING reference C body. The
 * baserom pins &gpSoundSystem into r7 across the __divsi3 BL and uses
 * r4 first as the LUT base, then as the computed frequency. Expressing
 * that r4 dataflow explicitly avoids the older NON_MATCHING branch's
 * overlapping LUT/gpSoundSystem register request. The current C body brings
 * the best isolated candidate to byte_diff 115 / insn_diff 38 with old_agbcc
 * -O2 -fforce-addr -fno-gcse -fno-expensive-optimizations. It also preserves the target's
 * top-level load order, keeps the interpolation pointer in r1, the
 * post-divide interpolation sum in r0, and the pitch-cache pointer in r0.
 * The remaining mismatch is structural: this agbcc Thumb backend reserves r7
 * as FRAME_POINTER_REGNUM, so ordinary allocation skips r7 and an explicit r7
 * register variable is not counted for the callee-save prologue. The compiler
 * therefore omits the target's r7 save, then colors the LUT loads and final
 * MMIO OR differently. Same family as the other NAKED sound functions in this
 * cluster (Sound_UpdateChannelEnvelopesA, Sound_TickStreamHead, SoundEnvelope_TickA0).
 *
 * Negative experiments: removing the cache casts or assigning the final
 * MMIO OR back through work destabilizes the literal pool/control flow;
 * explicit r0 load temps for LUT values still fold into r4 loads. Retesting
 * the older branch-local source shapes against the current split/header setup
 * did not reproduce the historical byte_diff 83 note. The older pitch worker's
 * lower score came from a stale `#ifdef NON_MATCHING` gate that did not compile
 * the C body under the function-specific matrix define; once gate-corrected,
 * the best older shape bottoms out at byte_diff 121, and it also used inline
 * asm for argument normalization. Focused register-convention probes do not
 * recover the target r7 save: agbcc rejects -fcall-saved-r7 / -fcall-used-r7
 * because r7 is the frame pointer register, while -ffixed-r7 is neutral.
 * Omitting -mthumb-interwork or spelling -mno-thumb-interwork shrinks the
 * object but keeps the wrong prologue. A diagnostic temp compiler with
 * FRAME_POINTER_REGNUM moved from r7 to r11 makes the prologue match and
 * improves the forced-C lane only to byte_diff 116 / insn_diff 35, so the
 * backend register model explains the first mismatch but is not a broad fix.
 * Retesting the r7/gpSoundSystem source shape on the current branch:
 * ordinary gpSoundSystem pointers and direct gpSoundSystem loads regress
 * to byte_diff 145, delaying the r7 load until after wrap regressses to 121,
 * and spelling the r7 value as a u32 address is neutral. Removing cache casts
 * improves instruction diff but regresses byte_diff to 119; final-OR temp
 * shapes regress to byte_diff 118 / insn_diff 44; removing the signed y temp
 * regresses to 119.
 * Introducing an explicit cached `freq` local is byte-neutral but improves the
 * instruction diff to 35. Retesting a full-width `freq` alias lowered
 * instruction diff but regressed byte_diff to 118+ and shrank the object;
 * spelling the interpolation delta as `lut[1] - lut[0]` recovered a
 * target-looking reload but likewise regressed byte_diff to 118+. Keeping the
 * first LUT sample in a named local preserves byte_diff 117 and improves the
 * instruction diff to 34 under old_agbcc -O2 -fforce-addr -fno-gcse. Comparing
 * and storing the pitch cache from the live r4 `work` value instead of the
 * `freq` alias lowers the byte score to 115 and moves the object to 154/168
 * with old_agbcc -O2 -fforce-addr -fno-gcse -fno-expensive-optimizations, though
 * the instruction diff worsens to 38. A tempting signed-y cast variant also
 * scores in this range, but is semantically invalid because `yNorm` has already
 * been shifted left by 16. A wider diagnostic flag pass found no ordinary flag
 * lane below byte_diff 115; -fno-peephole is neutral, and the same missing-r7-save
 * first mismatch remains.
 */

/* ROM-resident data — defined in src/data/sound_tables.c and
 * src/data/sound_pitch_luts.c respectively. */
extern vu16 *const sChannelFreqRegTable[4];
extern const u16 sPsgPitchLut[86];

#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_0802E5D8)
void Sound_EmitPsgPitch(s32 x, s32 y, s32 ch)
{
    register u32 work asm("r4");
    register SoundSystem **gpsp asm("r7");
    register s32 chReg asm("r5");
    register s32 chOffset asm("r6");
    register s32 sx_shifted asm("r0");
    register s32 sy asm("r2");
    register s32 xNorm asm("r3");
    register s32 yNorm asm("r1");
    SoundSystem *ss;
    u16 freq;

    chReg = ch;
    xNorm = (u16)x;
    yNorm = (u16)y;
    if (chReg > SOUND_PSG_MAX_TONE_CHANNEL)
        return;

    sx_shifted = (s32)(xNorm << 16);
    work = (u32)&sPsgPitchLut[SOUND_PSG_LUT_FIRST_SAMPLE];
    yNorm <<= 16;
    gpsp = &gpSoundSystem;
    chOffset = chReg << 1;

    /* Wrap x into [0, 83] by +/-84. Negative branch is a do-while
     * ahead of the shared exit check; positive branch is a back-edge
     * from the check. The pool literal for -84<<16 (0xffac0000) lives
     * between the two halves. */
    if (sx_shifted >= 0)
        goto check_high;
wrap_up:
    sx_shifted += SOUND_PSG_PITCH_WRAP_UP;
    xNorm = (u16)((u32)sx_shifted >> 16);
    sx_shifted = (s32)(xNorm << 16);
    if (sx_shifted < 0)
        goto wrap_up;
    goto check_high;
wrap_down:
    sx_shifted = sy + SOUND_PSG_PITCH_WRAP_DOWN;
    xNorm = (u16)((u32)sx_shifted >> 16);
check_high:
    sy = (s32)(xNorm << 16);
    if (sy >> 16 > SOUND_PSG_PITCH_MAX_INDEX)
        goto wrap_down;

    sy = yNorm >> 16;
    if (sy == 0) {
        register s32 lutOff asm("r0");

        lutOff = (s32)(xNorm << 16);
        lutOff >>= 15;
        lutOff += work;
        lutOff = *(u16 *)lutOff;
        work = lutOff;
    } else {
        register u16 *lut asm("r1");
        register u32 interp asm("r0");
        s32 delta;

        lut = (u16 *)((s16)xNorm * 2 + work);
        {
            u16 first = lut[0];

            work = first;
            delta = (s16)(lut[1] - first);
        }
        interp = work + (delta * sy) / SOUND_PSG_INTERP_DENOMINATOR;
        work = (u16)interp;
    }

    freq = (u16)work;
    {
        register u16 *cache asm("r0");

        ss = SOUND_SYSTEM_PSG_PITCH_CACHE_BASE(*gpsp);
        cache = (u16 *)((u8 *)ss + chOffset);
        if (*cache == (u16)work)
            return;
        *cache = (u16)work;
    }

    {
        register vu16 *const *regTable asm("r1");
        register s32 tableOffset asm("r0");
        vu16 *reg;
        u16 regval;

        regTable = sChannelFreqRegTable;
        tableOffset = chReg << 2;
        tableOffset += (u32)regTable;
        reg = *(vu16 **)tableOffset;

        regval = *reg;
        *reg = freq | (regval & SOUND_PSG_FREQ_LENGTH_ENABLE);
    }
}
#else
NAKED
void Sound_EmitPsgPitch(s32 x, s32 y, s32 ch)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    adds    r5, r2, #0\n"
        "    lsls    r0, r0, #0x10\n"
        "    lsrs    r3, r0, #0x10\n"
        "    lsls    r1, r1, #0x10\n"
        "    lsrs    r1, r1, #0x10\n"
        "    cmp     r5, #2\n"
        "    bgt     _0802E678\n"
        "    lsls    r0, r3, #0x10\n"
        "    ldr     r4, _0802E608            @ =sPsgPitchLut+2\n"
        "    lsls    r1, r1, #0x10\n"
        "    ldr     r7, _0802E60C            @ =gpSoundSystem (0x030065e0)\n"
        "    lsls    r6, r5, #1\n"
        "    cmp     r0, #0\n"
        "    bge     _0802E616\n"
        "_0802E5F6:\n"
        "    movs    r2, #0xa8\n"
        "    lsls    r2, r2, #0xf\n"
        "    adds    r0, r0, r2\n"
        "    lsrs    r3, r0, #0x10\n"
        "    lsls    r0, r3, #0x10\n"
        "    cmp     r0, #0\n"
        "    blt     _0802E5F6\n"
        "    b       _0802E616\n"
        "    .align  2, 0\n"
        "_0802E608: .4byte 0x082f8de2\n"
        "_0802E60C: .4byte 0x030065e0\n"
        "_0802E610:\n"
        "    ldr     r3, _0802E630\n"
        "    adds    r0, r2, r3\n"
        "    lsrs    r3, r0, #0x10\n"
        "_0802E616:\n"
        "    lsls    r2, r3, #0x10\n"
        "    asrs    r0, r2, #0x10\n"
        "    cmp     r0, #0x53\n"
        "    bgt     _0802E610\n"
        "    asrs    r2, r1, #0x10\n"
        "    cmp     r2, #0\n"
        "    bne     _0802E634\n"
        "    lsls    r0, r3, #0x10\n"
        "    asrs    r0, r0, #0xf\n"
        "    adds    r0, r0, r4\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r4, r0, #0\n"
        "    b       _0802E656\n"
        "    .align  2, 0\n"
        "_0802E630: .4byte 0xffac0000\n"
        "_0802E634:\n"
        "    lsls    r1, r3, #0x10\n"
        "    asrs    r1, r1, #0xf\n"
        "    adds    r1, r1, r4\n"
        "    ldrh    r0, [r1, #0]\n"
        "    adds    r4, r0, #0\n"
        "    ldrh    r0, [r1, #2]\n"
        "    ldrh    r1, [r1, #0]\n"
        "    subs    r0, r0, r1\n"
        "    lsls    r0, r0, #0x10\n"
        "    asrs    r0, r0, #0x10\n"
        "    muls    r0, r2\n"
        "    movs    r1, #0xff\n"
        "    bl      __divsi3\n"
        "    adds    r0, r4, r0\n"
        "    lsls    r0, r0, #0x10\n"
        "    lsrs    r4, r0, #0x10\n"
        "_0802E656:\n"
        "    ldr     r0, [r7, #0]\n"
        "    adds    r0, #0xb4\n"
        "    adds    r0, r0, r6\n"
        "    ldrh    r1, [r0, #0]\n"
        "    cmp     r1, r4\n"
        "    beq     _0802E678\n"
        "    strh    r4, [r0, #0]\n"
        "    ldr     r1, _0802E680            @ =sChannelFreqRegTable\n"
        "    lsls    r0, r5, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r2, [r0, #0]\n"
        "    ldrh    r1, [r2, #0]\n"
        "    movs    r0, #0x80\n"
        "    lsls    r0, r0, #7\n"
        "    ands    r0, r1\n"
        "    orrs    r4, r0\n"
        "    strh    r4, [r2, #0]\n"
        "_0802E678:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_0802E680: .4byte sChannelFreqRegTable\n"
        "    .syntax divided\n");
}
#endif
