#include "types.h"

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
 * Struct shapes here are scaffold-grade — sized for the offsets this
 * function touches. Promote to include/sound.h once neighbouring
 * sub_0802F4B0 / sub_0802F054 / sub_0802F2FC land and confirm them.
 */

typedef struct SoundSystem {
    u8 _pad00[0x10];
    u32 chDirty[4]; /* +0x10 — one dirty-flag word per channel */
    u8 _pad20[0x72];
    u8 volCache[4 * 8]; /* +0x92 — ch volume cache, 8 bytes apart */
    /* ch0: +0x92  ch1: +0x9a  ch2: +0xa2 (waveVolCache)  ch3: +0xaa */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

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
        u8 *cache = (u8 *)ss + ch * 8 + 0x92;
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
            u32 masked = regVal & 0x0fff;
            register u32 shifted asm("r1");
            asm("" : "=r"(shifted) : "0"(newCode << 12));
            *reg = masked | shifted;
        }

        dirty = (u32 *)((u8 *)gpSoundSystem + 16);
        dirty = (u32 *)((u8 *)dirty + ch);
        *dirty |= 0x200;
    } else if (ch == 2) {
        SoundSystem *ss = gpSoundSystem;
        u8 *cache = (u8 *)ss + 0xa2;
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
            u32 masked = regVal & 0x00ff;
            u32 mappedNew = *pNew;
            u32 shifted = mappedNew << 8;
            *reg = masked | shifted;
        }

        gpSoundSystem->chDirty[2] |= 0x200;
    }
}
