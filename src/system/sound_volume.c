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

/* ROM-resident data tables. Address-named for now — promote when the
 * surrounding asm slice (text_0x0802e724.o etc.) gets unblobbed. */
#define sChannelRegTable ((vu16 *const *)0x083dda2c) /* 4 entries */
#define sWaveVolLut      ((const u8 *)0x083dda3c)    /* 16 entries */

void sub_0802E684(s32 vol, s32 chIn)
{
    register s32 newCode asm("r4");
    register s32 ch asm("r3");
    register s32 oldCode asm("r1");
    register vu16 *reg asm("r2");
    register u16 regVal asm("r1");

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
            u32 tbl;
            asm("" : "=r"(tbl) : "0"((u32)(const u8 *)sChannelRegTable));
            ch <<= 2;
            reg = *(vu16 *const *)(ch + tbl);
        }
        regVal = *reg;
        {
            register u32 masked asm("r0") = regVal & 0x0fff;
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
        register const u8 *pOld asm("r1");
        register const u8 *pNew asm("r3");
        register u32 oldMapped asm("r1");
        register u32 newMapped asm("r0");

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
            register u32 masked asm("r0") = regVal & 0x00ff;
            register u32 mappedNew asm("r3") = *pNew;
            register u32 shifted asm("r1") = mappedNew << 8;
            *reg = masked | shifted;
        }

        gpSoundSystem->chDirty[2] |= 0x200;
    }
}
