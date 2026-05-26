#include "macros.h"
#include "types.h"

/* Two u16 lookup tables consumed by sub_0802E5D8 (PSG channel
 * configuration writer, still in asm) and friends. Both look like
 * smooth monotonic curves with logarithmic / saturation shape — most
 * likely envelope or note-frequency conversion LUTs for the noise /
 * wave-mix path.
 *
 * sUnknownSoundLut_82F8DE0: 37 u16 entries, values 0x077b..0x07ef,
 *   tiny deltas 1..7 — narrow "fine-tune" or "near-unity" curve.
 *   Loaded at 0x0802e5ea via `ldr r4, =0x082f8de2` (note the +2 offset
 *   suggests `lut[idx - 1]` indexing, which is consistent with the
 *   surrounding `lsls r6, r5, #1` doubling the channel index.
 *
 * sUnknownSoundLut_82F8E2A: 49 u16 entries, values 0x002c..0x0782,
 *   wide deltas 7..112 — broader "coarse-tune" curve covering ~5x
 *   the dynamic range.
 *
 * Names are descriptively-generic pending decomp of sub_0802E5D8.
 * Promote to concrete names (`sNoiseFreqFineLut`, etc.) once the
 * caller is read and the math is clear. The pair lands at
 * [0x082f8de0, 0x082f8e8c) — immediately before gEepromIdString.
 */

const u16 sUnknownSoundLut_82F8DE0[37] = INCBIN_U16("data/sound/lut_82f8de0.bin");

const u16 sUnknownSoundLut_82F8E2A[49] = INCBIN_U16("data/sound/lut_82f8e2a.bin");
