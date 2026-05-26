#include "macros.h"
#include "types.h"

/* PSG channel register/LUT tables consumed by the sound subsystem
 * (sub_0802E684, sub_0802E5D8, sub_0802F4B0, …).
 *
 * The four DMG-style PSG channels each have two MMIO ports that the
 * mixer touches: a "duty/length/envelope" control register and a
 * "frequency" control register. The tables below hold per-channel
 * pointers for both, in matching order so a single channel index
 * picks the right pair.
 *
 *     ch 0 -> 0x04000062 (SOUND1CNT_H) / 0x04000064 (SOUND1CNT_X)
 *     ch 1 -> 0x04000068 (SOUND2CNT_L) /  -        / 0x0400006C (SOUND2CNT_H)
 *     ch 2 -> 0x04000072 (SOUND3CNT_H) / 0x04000074 (SOUND3CNT_X)
 *     ch 3 -> 0x04000078 (SOUND4CNT_L) / 0x0400007C (SOUND4CNT_H)
 *
 * In the baserom these eight words sit at 0x083dda1c (freq) and
 * 0x083dda2c (duty) as raw .word literals. A C array of `vu16 *const`
 * with the same MMIO addresses lays out byte-identically.
 *
 * sWaveVolLut is the 16-entry volume code -> SOUND3CNT_H bit-pattern
 * table used only for the wave channel: it maps a 4-bit volume code
 * (0..15) into the 8-bit `<<8` mask that gets written into bits 8..15
 * of SOUND3CNT_H. Source bytes verbatim from the baserom.
 */

/* 0x083dda1c — channel "frequency / control" MMIO registers.
 * Loaded by sub_0802E5D8 at instruction 0x0802e664 via
 * `ldr r1, =sChannelFreqRegTable; ldr r2, [r1, r5, lsl #2]`. */
vu16 *const sChannelFreqRegTable[4] = {
    (vu16 *)0x04000064,
    (vu16 *)0x0400006C,
    (vu16 *)0x04000074,
    (vu16 *)0x0400007C,
};

/* 0x083dda2c — channel "duty/length/envelope" MMIO registers.
 * Loaded by sub_0802E684 (sound_volume.c). */
vu16 *const sChannelRegTable[4] = {
    (vu16 *)0x04000062,
    (vu16 *)0x04000068,
    (vu16 *)0x04000072,
    (vu16 *)0x04000078,
};

/* 0x083dda3c — wave-channel 4-bit volume code -> SOUND3CNT_H bits 8..15. */
const u8 sWaveVolLut[16] = INCBIN_U8("data/sound/wave_vol_lut.bin");
