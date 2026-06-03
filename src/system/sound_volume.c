#include "sound.h"

/* Per-channel volume setter for the four DMG-style PSG channels.
 *
 * Called from sub_0802F4B0 (the per-VBlank sound mixer) once per
 * "volume-request" slot. `vol` is the raw amplitude (0..127); it gets
 * divided by 8 to a 4-bit code which goes into bits 12..15 of the
 * channel's duty/length/envelope MMIO register:
 *
 *     ch 0 -> 0x04000062  (SOUND1CNT_H)
 *     ch 1 -> 0x04000068  (SOUND2CNT_L)
 *     ch 2 -> 0x04000072  (SOUND3CNT_H)   wave channel, see below
 *     ch 3 -> 0x04000078  (SOUND4CNT_L)
 *
 * Channel 2 (the wave channel) is special-cased: its volume on
 * SOUND3CNT_H is a 3-bit code in bits 13..15 (mute / 100% / 50% / 25%
 * / 75%-forced), so the 4-bit input is run through sWaveVolLut and
 * the resulting byte is written into bits 8..15.
 *
 * Per-channel last-written codes are cached on the SoundSystem state
 * so an unchanged call short-circuits the MMIO write. A successful
 * write sets dirty bit 0x200 in ss->chDirty[ch].
 *
 * The cache offsets are named in sound.h, but spelling the generic channel
 * cache as SOUND_SYSTEM_VOL_CACHE changes the target's add/load order here.
 * Keep the raw address arithmetic until this function's register shape is
 * ready to move.
 */

/* ROM-resident data tables — defined in src/data/sound_tables.c. */
extern vu16 *const sChannelRegTable[4];
extern const u8 sWaveVolLut[16];

void sub_0802E684(s32 vol, s32 chIn)
{
    register s32 newCode asm("r4");
    register s32 ch asm("r3");
    s32 oldCode;
    vu16 *reg;
    u16 regVal;

    asm("" : "=r"(newCode) : "0"(vol)); /* mov r4, vol — fight agbcc's lsrs-fold */
    ch = chIn;
    newCode = (u32)newCode >> 3;

    if (ch <= 1 || ch == 3) {
        SoundSystem *ss = gpSoundSystem;
        u8 *cache = (u8 *)ss + ch * 8 + SOUND_SYSTEM_VOL_CACHE_OFFSET;
        u32 *dirty;

        oldCode = *cache;
        *cache = newCode;
        if (oldCode == newCode)
            return;

        {
            u32 tbl = (u32)(const u8 *)sChannelRegTable;
            ch <<= 2;
            reg = *(vu16 *const *)(ch + tbl);
        }
        regVal = *reg;
        {
            u32 masked = regVal & SOUND_CHANNEL_VOL_ENV_LOW_MASK;
            register u32 shifted asm("r1");
            asm("" : "=r"(shifted) : "0"(newCode << 12));
            *reg = masked | shifted;
        }

        dirty = (u32 *)((u8 *)gpSoundSystem + SOUND_CH_FLAGS_OFFSET);
        dirty = (u32 *)((u8 *)dirty + ch);
        *dirty |= SOUND_FLAG_PSG_REG_DIRTY;
    } else if (ch == 2) {
        SoundSystem *ss = gpSoundSystem;
        u8 *cache = (u8 *)ss + SOUND_SYSTEM_VOL_CACHE_OFFSET + 2 * 8;
        register const u8 *base asm("r0");
        const u8 *pOld;
        register const u8 *pNew asm("r3");
        u32 oldMapped;
        u32 newMapped;

        oldCode = *cache;
        *cache = newCode;

        base = sWaveVolLut;
        pOld = (const u8 *)(oldCode + (u32)base);
        pNew = (const u8 *)(newCode + (u32)base);
        oldMapped = *pOld;
        newMapped = *pNew;
        if (oldMapped == newMapped)
            return;

        {
            vu16 *const *tbl = sChannelRegTable;
            reg = tbl[2];
        }
        regVal = *reg;
        {
            u32 masked = regVal & SOUND_WAVE_VOL_LOW_MASK;
            u32 mappedNew = *pNew;
            u32 shifted = mappedNew << 8;
            *reg = masked | shifted;
        }

        gpSoundSystem->chFlags[2] |= SOUND_FLAG_PSG_REG_DIRTY;
    }
}
