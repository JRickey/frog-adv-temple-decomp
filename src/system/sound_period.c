#include "types.h"

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
 *   b > a   → sNoteRatioTable     (12-tone *2^(n/12) ratios, up)
 *   b < a   → sInversePitchTable  (12-tone /2^(n/12) ratios, down)
 *   b == a  → no LUT lookup; return (s << 12) / divisor
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
 */

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
