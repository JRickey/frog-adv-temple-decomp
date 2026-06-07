#include "sound.h"

/* SoundHandle_Retire — retire a sound handle if it's still active.
 *
 * Same handle layout as SoundHandle_IsActive: bits 16..23 carry the slot index,
 * and slotPtrTable[idx] must still match the handle token. If both
 * conditions hold, forwards to Sound_RetireChannel(idx) — the slot-retire
 * helper at ss+0x120 — and returns 1. Otherwise returns 0.
 *
 * Unlike SoundHandle_IsActive, this path does not consult channelSeqs at
 * ss+0x114; the caller has already committed to retiring the slot if
 * the token still matches.
 *
 * Compiled with old_agbcc to stay byte-identical to the adjacent
 * Sound_DrainActiveSlots / SoundHandle_IsActive slice (same toolchain pin).
 */

extern void Sound_RetireChannel(s32 idx);

u32 SoundHandle_Retire(u32 handle)
{
    SoundSystem *ss;
    u32 idx;
    void **slotTable;

    if (handle == 0)
        return 0;
    idx = (handle >> 16) & 0xff;
    ss = gpSoundSystem;
    slotTable = SOUND_SYSTEM_SLOT_HANDLE_TABLE(ss);
    if ((u32)slotTable[idx] != handle)
        return 0;
    Sound_RetireChannel((s32)idx);
    return 1;
}
