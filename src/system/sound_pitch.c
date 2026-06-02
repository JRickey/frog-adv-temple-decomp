#include "macros.h"
#include "sound.h"

/* sub_0802E5D8 — per-tone-channel pitch / frequency setter.
 *
 * Called from the per-VBlank mixer (sub_0802F4B0) once per active
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
 * Companion to sub_0802E684 in sound_volume.c (volume setter, called
 * for the same channels by the same mixer dispatch).
 *
 * Shipped as NAKED inline asm + a NON_MATCHING reference C body. The
 * baserom pins gpSoundSystem into r7 across the __divsi3 BL and uses
 * r0 (caller-saved) for the wrap-loop sx_shifted accumulator while r2
 * holds the +84/-84 constant. agbcc 2.x consistently chooses the
 * opposite shape — r2 for sx_shifted, r0 for the constant — and does
 * not preserve r7 across the libgcc divide because it knows __divsi3
 * does not clobber r7. Block-scoping sx_shifted, pinning ch/chOffset/
 * gpsp to r5/r6/r7, and matching the entry normalization brought the
 * forced C branch down to byte_diff 78, but the remaining structural
 * mismatch (5-reg push, register choice in wrap loop) resists further
 * source-level rearrangement. Same family as the other NAKED sound
 * functions in this cluster (sub_0802EC7C, sub_0802EDF0, sub_0802EA80).
 */

/* ROM-resident data — defined in src/data/sound_tables.c and
 * src/data/sound_pitch_luts.c respectively. */
extern vu16 *const sChannelFreqRegTable[4];
extern const u16 sPsgPitchLut[86];

#ifdef NON_MATCHING
void sub_0802E5D8(s32 x, s32 y, s32 ch)
{
    const u16 *lut1;
    register SoundSystem **gpsp asm("r7");
    register s32 chReg asm("r5");
    register s32 chOffset asm("r6");
    u16 freq;
    register s32 sx_shifted asm("r0");
    register s32 sy asm("r2");
    register s32 xNorm asm("r3");
    register s32 yNorm asm("r1");

    chReg = ch;
    yNorm = y;
    asm("lsl r0, r0, #0x10\n\tlsr %0, r0, #0x10\n\tlsl %1, %1, #0x10\n\tlsr %1, %1, #0x10"
        : "=r"(xNorm), "+r"(yNorm)
        :
        : "r0");
    if (chReg > 2)
        return;

    sx_shifted = (s32)(xNorm << 16);
    lut1 = &sPsgPitchLut[1];
    gpsp = &gpSoundSystem;
    yNorm <<= 16;
    chOffset = chReg << 1;

    /* Wrap x into [0, 83] by +/-84. Negative branch is a do-while
     * ahead of the shared exit check; positive branch is a back-edge
     * from the check. The pool literal for -84<<16 (0xffac0000) lives
     * between the two halves. */
    if (sx_shifted >= 0)
        goto check_high;
wrap_up:
    sx_shifted += 0x540000;
    xNorm = (u16)((u32)sx_shifted >> 16);
    sx_shifted = (s32)(xNorm << 16);
    if (sx_shifted < 0)
        goto wrap_up;
    goto check_high;
wrap_down:
    sx_shifted += (s32)0xffac0000;
    xNorm = (u16)((u32)sx_shifted >> 16);
check_high:
    sx_shifted = (s32)(xNorm << 16);
    if (sx_shifted >> 16 > 83)
        goto wrap_down;

    sy = yNorm >> 16;
    if (sy != 0) {
        s32 a = lut1[(s16)xNorm];
        s32 b = lut1[(s16)xNorm + 1];
        s32 delta = (s16)(b - a);
        freq = (u16)(a + (delta * sy) / 255);
    } else {
        freq = lut1[(s16)xNorm];
    }

    {
        u16 *cache = (u16 *)((u8 *)(*gpsp) + 0xb4 + chOffset);
        if (*cache == freq)
            return;
        *cache = freq;
    }

    {
        vu16 *reg = sChannelFreqRegTable[chReg];
        u16 regval = *reg;
        *reg = freq | (regval & 0x4000);
    }
}
#else
NAKED
void sub_0802E5D8(s32 x, s32 y, s32 ch)
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
