#include "macros.h"
#include "types.h"

/* PSG channel pitch LUT consumed by Sound_EmitPsgPitch.
 *
 * 86 u16 entries spanning [0x082f8de0, 0x082f8e8c). Indexed with a
 * semitone-style integer key in [0, 83], wrapped mod-84 by the caller,
 * then linearly interpolated by a signed 8-bit fractional offset.
 * Each entry encodes the per-channel hardware frequency divider value
 * written into the PSG control register (SOUND1CNT_X / SOUND2CNT_H /
 * SOUND3CNT_X). The discontinuity at index 36 to 37 (0x07ef to 0x002c)
 * is the rate-register wrap between adjacent octave bands.
 *
 * Loaded at Sound_EmitPsgPitch+0x12 via `ldr r4, =&sPsgPitchLut[1]` (a u16
 * pointer one element into the table — the function indexes lut[r3+1]
 * and lut[r3+2] for the bracket pair around the integer key).
 */

const u16 sPsgPitchLut[86] = INCBIN_U16("data/sound/psg_pitch_lut.bin");
