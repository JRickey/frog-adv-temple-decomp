#include "macros.h"
#include "types.h"

/* Twelve-tone equal-temperament pitch lookup tables consumed by the
 * sound mixer (Sound_OpcodeDispatch / SoundMixer_VBlankUpdate cluster, still in asm).
 *
 * sNoteRatioTable maps a semitone index n to `0x1000 * 2^(n/12)`. The
 * first 48 entries cover 4 octaves of upward pitch ratios; entries
 * 48..127 are padded with 0xffff (unused range). Used to multiply a
 * base rate by a semitone shift.
 *
 *   idx  0 -> 0x1000 (×1.0)
 *   idx 12 -> 0x2000 (×2.0)
 *   idx 24 -> 0x4000 (×4.0)
 *   idx 36 -> 0x8000 (×8.0)
 *   idx 47 -> 0xf1a1 (≈×15.1, last populated entry)
 *
 * sInversePitchTable maps a semitone index n to `0x1000 / 2^(n/12)`,
 * the inverse direction (downward ratios). 128 entries, each halving
 * every 12 steps:
 *
 *   idx   0 -> 0x1000 (1/1)
 *   idx  12 -> 0x0800 (1/2)
 *   idx  24 -> 0x0400 (1/4)
 *   idx  36 -> 0x0200 (1/8)
 *   idx  48 -> 0x0100 (1/16)
 *   idx 127 -> 0x0002
 *
 * Both tables sit in [0x083ddadc, 0x083ddcdc) — sandwiched between
 * sDefaultSquareWavePcm and sSoundOpcodeHandlers. Pulled into .rodata
 * via the linker so the matching slice lands at the right ROM offset.
 */

const u16 sNoteRatioTable[128] = INCBIN_U16("data/sound/note_ratio_table.bin");

const u16 sInversePitchTable[128] = INCBIN_U16("data/sound/inverse_pitch_table.bin");
