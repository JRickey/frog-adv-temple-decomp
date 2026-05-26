#include "types.h"
#include "macros.h"

/* sub_080301C4 — per-mix-entry pitch-ratio scaler + period divide.
 *
 * Called from the mixer (sub_0802F4B0) stage-3 commit pass for each
 * non-NULL slot whose flag bit 0x40 is set AND whose flags include
 * 0x1400 — see sound_mixer.c. The mixer accumulates six u16 samples
 * from the slot's interleaved acc[] fields, casts the result to u16,
 * and splits it into two bytes:
 *
 *   b = (acc_sum >> 8) & 0xff   (integer semitone delta, second arg)
 *   c =  acc_sum       & 0xff   (fractional 1/256 bias, third arg)
 *
 * Given a mix entry with anchor semitone `a = entry->anchor` and base
 * period `s = entry->basePeriod`, this routine returns
 *
 *   (s * pitch_ratio_lerp(a, b, c)) / gpSoundSystem->divisor
 *
 * where pitch_ratio_lerp uses one of two LUTs depending on the sign
 * of (b - a):
 *
 *   b > a   - sNoteRatioTable     (12-tone *2^(n/12) ratios, up)
 *   b < a   - sInversePitchTable  (12-tone /2^(n/12) ratios, down)
 *   b == a  - no LUT lookup; return (s << 12) / divisor
 *
 * The "interpolation" form (c != 0) linearly blends adjacent entries
 * table[d] and table[d+1] by c/256; the "no fraction" form (c == 0)
 * uses table[d] verbatim and skips the second load. The 16.16 product
 * is then divided by gpSoundSystem->divisor (the global sample-rate
 * scale, u16 at +2) via the libgcc __udivsi3 helper at 0x08033ee4.
 *
 * Companion to sub_0802E5D8 (PSG-channel pitch setter in sound_pitch.c)
 * — that path uses sPsgPitchLut for the PSG period registers; this
 * path uses the slot-local sNoteRatioTable/sInversePitchTable for the
 * sample-streaming mix entries.
 *
 * Shipped as NAKED + #ifdef NON_MATCHING. The function BLs the libgcc
 * __udivsi3 helper, which puts it in the "push {r4-r7, lr} + libgcc
 * helper BL" class flagged in docs/codegen-notes.md as a third
 * unmatchable shape for agbcc 2.x — even a clean pure-C body with the
 * exact same control flow emits one extra `.short 0x0000` pad before
 * the trailing pool word and shifts every subsequent relative offset
 * by 4 bytes. Iter 9 shipped a pure-C version that briefly appeared
 * to match (cached frog_us.gba from in-flight build state); a clean
 * rebuild revealed byte_diff 136. See docs/decisions.md "Iter-9
 * false-positive verification".
 */

#ifdef NON_MATCHING
/* Reference body — describes the algorithm for the phase-3 PC port.
 * Does NOT byte-match; agbcc 2.x inserts an extra short pad before
 * the trailing pool word for this prologue shape. */

typedef struct SoundSystem {
    u8 _pad00[2];
    u16 divisor; /* +0x02 — global sample-rate divisor (period denominator) */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

/* ROM-resident pitch LUTs — defined in src/data/sound_pitch.c. */
extern const u16 sNoteRatioTable[128];    /* 0x083ddadc — *2^(n/12) up */
extern const u16 sInversePitchTable[128]; /* 0x083ddbdc — /2^(n/12) down */

/* libgcc unsigned-int division helper (0x08033ee4). */
extern u32 __udivsi3(u32 num, u32 den);

typedef struct MixEntry {
    u8 _pad00[8];
    u16 basePeriod; /* +0x08 — slot's nominal period in 4.12 fixed-point */
    u8 anchor;      /* +0x0a — anchor semitone index */
} MixEntry;

u32 sub_080301C4(MixEntry *entry, u8 b, u8 c)
{
    u32 a = entry->anchor;
    u32 r3;

    if (c == 0) {
        if (b == a) {
            r3 = entry->basePeriod << 12;
        } else {
            u32 s = entry->basePeriod;
            u16 ratio;
            if (a < b) {
                ratio = sNoteRatioTable[b - a];
            } else {
                ratio = sInversePitchTable[a - b];
            }
            r3 = ratio * s;
        }
    } else {
        u32 d;
        u16 lo, hi;
        s32 delta;
        u32 ratio;
        if (b >= a) {
            d = b - a;
            lo = sNoteRatioTable[d];
            hi = sNoteRatioTable[d + 1];
            delta = (s32)hi - (s32)lo;
        } else {
            d = a - b;
            lo = sInversePitchTable[d];
            hi = sInversePitchTable[d + 1];
            delta = (s32)lo - (s32)hi;
        }
        ratio = lo + (((u32)delta * c) >> 8);
        r3 = entry->basePeriod * ratio;
    }

    return (u16)__udivsi3(r3, gpSoundSystem->divisor);
}

#else
NAKED
void sub_080301C4(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    adds    r4, r0, #0\n"
        "    lsls    r1, r1, #24\n"
        "    lsrs    r3, r1, #24\n"
        "    adds    r1, r3, #0\n"
        "    lsls    r2, r2, #24\n"
        "    lsrs    r5, r2, #24\n"
        "    ldrb    r0, [r4, #0xa]\n"
        "    cmp     r5, #0\n"
        "    bne     _08030206\n"
        "    cmp     r3, r0\n"
        "    beq     _08030200\n"
        "    ldrh    r2, [r4, #8]\n"
        "    cmp     r0, r3\n"
        "    bcs     _080301EC\n"
        "    ldr     r1, _080301E8            @ =sNoteRatioTable\n"
        "    subs    r0, r3, r0\n"
        "    b       _080301F0\n"
        "_080301E8: .4byte sNoteRatioTable\n"
        "_080301EC:\n"
        "    ldr     r1, _080301FC            @ =sInversePitchTable\n"
        "    subs    r0, r0, r3\n"
        "_080301F0:\n"
        "    lsls    r0, r0, #1\n"
        "    adds    r0, r0, r1\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r3, r0, #0\n"
        "    muls    r3, r2\n"
        "    b       _08030244\n"
        "_080301FC: .4byte sInversePitchTable\n"
        "_08030200:\n"
        "    ldrh    r4, [r4, #8]\n"
        "    lsls    r3, r4, #12\n"
        "    b       _08030244\n"
        "_08030206:\n"
        "    cmp     r3, r0\n"
        "    bcc     _08030224\n"
        "    ldr     r2, _08030220            @ =sNoteRatioTable\n"
        "    subs    r1, r3, r0\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r2\n"
        "    ldrh    r3, [r0, #0]\n"
        "    adds    r1, #1\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r1, r1, r2\n"
        "    ldrh    r1, [r1, #0]\n"
        "    subs    r0, r1, r3\n"
        "    b       _08030238\n"
        "_08030220: .4byte sNoteRatioTable\n"
        "_08030224:\n"
        "    ldr     r2, _0803025C            @ =sInversePitchTable\n"
        "    subs    r1, r0, r1\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r2\n"
        "    ldrh    r3, [r0, #0]\n"
        "    adds    r1, #1\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r1, r1, r2\n"
        "    ldrh    r1, [r1, #0]\n"
        "    subs    r0, r3, r1\n"
        "_08030238:\n"
        "    muls    r0, r5\n"
        "    lsrs    r0, r0, #8\n"
        "    adds    r0, r3, r0\n"
        "    ldrh    r4, [r4, #8]\n"
        "    adds    r3, r4, #0\n"
        "    muls    r3, r0\n"
        "_08030244:\n"
        "    ldr     r0, _08030260            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r0, #0]\n"
        "    ldrh    r1, [r0, #2]\n"
        "    adds    r0, r3, #0\n"
        "    bl      __udivsi3\n"
        "    adds    r3, r0, #0\n"
        "    lsls    r0, r3, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    pop     {r4, r5}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "_0803025C: .4byte sInversePitchTable\n"
        "_08030260: .4byte 0x030065e0\n"
        "    .syntax divided\n");
}
#endif
