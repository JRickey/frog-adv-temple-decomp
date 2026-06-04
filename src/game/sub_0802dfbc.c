#include "sound.h"

/* sub_0802DFBC — set the period byte of a SW-slot identified by handle,
 * then mark the slot dirty.
 *
 * handle: bits 16..23 carry the slot index (same layout as sub_0802E1C8 etc.)
 * scale:  the value to write as `scale << 1`; if that byte is non-zero,
 *         the period is further incremented by 1.
 *
 * Matching notes:
 *   - scaleSaved (r4) and period (r0) are pinned so agbcc can emit
 *     `lsls r0, r4, #1` then `lsls r0, r0, #24` without folding to r4 << 25.
 *   - slotPtr (r1) is pinned so the `adds r1, #43` immediate-add produces the
 *     period-field pointer from the slot base already in r1.
 *   - The first access uses `ss = gpSoundSystem` (a VALUE copy), while the
 *     second and third use `*pPool`.  This splits the RTX for swSlots from the
 *     r1 destination, preventing optabs from swapping the `plus` operands and
 *     yielding `adds r1, r2, r1` / `adds r0, r2, r0` (Rn=dest form) instead of
 *     the wrong `adds r1, r1, r2` form.
 */
void sub_0802DFBC(u32 handle, u32 scale)
{
    register u32 scaleSaved asm("r4") = scale;
    register u32 period asm("r0");
    u32 idx;
    u8 *p;
    SoundSlotAcc *slot;
    SoundSystem **pPool;
    SoundSystem *ss;

    if (handle == 0)
        return;

    idx = (handle >> 16) & 0xff;
    ss = gpSoundSystem;
    pPool = &gpSoundSystem;

    {
        register u8 *slotPtr asm("r1");
        u8 *swSlotsBase;
        u8 *swSlots;

        swSlotsBase = (u8 *)ss + SOUND_SYSTEM_SW_SLOTS_OFFSET;
        swSlots = *(u8 **)swSlotsBase;
        idx <<= 6;
        slotPtr = (u8 *)(idx + (u32)swSlots);
        period = scaleSaved << 1;
        *(slotPtr + 0x2b) = period;
        period <<= 24;
        if (period != 0) {
            swSlotsBase = (u8 *)*pPool + SOUND_SYSTEM_SW_SLOTS_OFFSET;
            p = (u8 *)(idx + (u32) * (u8 **)swSlotsBase);
            *(p + 0x2b) += 1;
        }
        swSlotsBase = (u8 *)*pPool + SOUND_SYSTEM_SW_SLOTS_OFFSET;
        slot = (SoundSlotAcc *)(idx + (u32) * (u8 **)swSlotsBase);
    }
    slot->flags |= SOUND_FLAG_UPDATE_DIRTY;
}
