#include "sound.h"

/* sub_0802E100 — retire a sound handle if it's still active.
 *
 * Same handle layout as sub_0802E184: bits 16..23 carry the slot index,
 * and slotPtrTable[idx] must still match the handle token. If both
 * conditions hold, forwards to sub_0802F9F0(idx) — the slot-retire
 * helper at ss+0x120 — and returns 1. Otherwise returns 0.
 *
 * Unlike sub_0802E184, this path does not consult channelSeqs at
 * ss+0x114; the caller has already committed to retiring the slot if
 * the token still matches.
 *
 * Compiled with old_agbcc to stay byte-identical to the adjacent
 * sub_0802E13C / sub_0802E184 slice (same toolchain pin).
 */

extern void sub_0802F9F0(s32 idx);

u32 sub_0802E100(u32 handle)
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
    sub_0802F9F0((s32)idx);
    return 1;
}
