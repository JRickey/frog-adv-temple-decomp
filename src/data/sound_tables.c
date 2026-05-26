#include "macros.h"
#include "types.h"

/* PSG channel volume tables consumed by sub_0802E684 (sound_volume.c).
 *
 * sChannelRegTable maps the 4 DMG-style channels to their per-channel
 * duty/length/envelope MMIO register:
 *
 *     ch 0 -> 0x04000062  (SOUND1CNT_H)
 *     ch 1 -> 0x04000068  (SOUND2CNT_L)
 *     ch 2 -> 0x04000072  (SOUND3CNT_H)   wave channel
 *     ch 3 -> 0x04000078  (SOUND4CNT_L)
 *
 * In the baserom these four words sit at 0x083dda2c as raw .word
 * literals (the surrounding asm is the bottom of the sound code that
 * starts around 0x0802e684). A C array of `vu16 *const` with the same
 * four MMIO addresses lays out byte-identically.
 *
 * sWaveVolLut is the 16-entry volume code -> SOUND3CNT_H bit-pattern
 * table used only for the wave channel: it maps a 4-bit volume code
 * (0..15) into the 8-bit `<<8` mask that gets written into bits 8..15
 * of SOUND3CNT_H. Source bytes verbatim from the baserom.
 */

vu16 *const sChannelRegTable[4] = {
    (vu16 *)0x04000062,
    (vu16 *)0x04000068,
    (vu16 *)0x04000072,
    (vu16 *)0x04000078,
};

const u8 sWaveVolLut[16] = INCBIN_U8("data/sound/wave_vol_lut.bin");
