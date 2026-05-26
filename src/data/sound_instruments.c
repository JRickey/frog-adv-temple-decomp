#include "macros.h"
#include "types.h"

/* Built-in PCM "instrument" used by the sound subsystem as the default
 * square-wave timbre. Referenced from 0x08030ba8 and 0x08030d5c inside
 * the sound dispatcher code at 0x08030000..0x080315d8 (still in asm).
 *
 * The header is read as four u32 fields, then the 128 PCM samples are
 * walked as signed 8-bit data. Splitting the structure across two
 * symbols (a 16-byte header literal + an INCBIN-loaded PCM payload)
 * makes sense semantically (different lifetimes / nameability) AND
 * sidesteps a pedantic narrowing diagnostic on (s8)0x80 inside an
 * aggregate initializer.
 *
 *   0x083dda4c  sDefaultSquareWaveInstr — 4 × u32 header
 *                 length       = 0x00000080  (128 samples)
 *                 loopPoint    = 0xffffffff  (no loop)
 *                 pitchOrRate  = 0x003020b8  (≈ fixed-point base pitch)
 *                 _pad         = 0x00000000
 *   0x083dda5c  sDefaultSquareWavePcm[128] — signed-8-bit PCM
 *                 first 64 bytes  = 0x7f (+127)
 *                 next  64 bytes  = 0x80 (-128)
 *
 * The PCM payload is a perfect square wave (half full-positive, half
 * full-negative). The mixer (sub_080315D8 / sub_0802F4B0) wraps it
 * with envelope + pitch state to synthesize PSG-style tones for
 * slots that do not map to the hardware PSG channels.
 *
 * Field names and the typedef are scaffold-grade pending decomp of
 * the two sound dispatchers that consume this structure. Promote to a
 * real `SoundInstrument` typedef once those land.
 */

typedef struct SoundWaveInstrument {
    u32 length;      /* +0x00 — sample count */
    u32 loopPoint;   /* +0x04 — 0xffffffff = no loop */
    u32 pitchOrRate; /* +0x08 — fixed-point pitch base */
    u32 _pad0c;      /* +0x0c — observed zero */
    /* PCM samples follow immediately at +0x10 — see sDefaultSquareWavePcm. */
} SoundWaveInstrument;

const SoundWaveInstrument sDefaultSquareWaveInstr = {
    0x00000080,
    0xffffffff,
    0x003020b8,
    0x00000000,
};

const u8 sDefaultSquareWavePcm[128] = INCBIN_U8("data/sound/default_square_wave_pcm.bin");
