#include "sound.h"

/* Matching notes:
 * - handle → r3 (volatile), val → r5 (callee-saved), valCopy → r6 (callee-saved),
 *   chOff → r4 (callee-saved, reused: 0x120 then idx*4), old → r3 (reuses handle reg)
 * - ss pinned to r1; adj (r2) and swSlotsPtr (r1) pinned in >= 4 path
 * - `new_var` forces conservative alias reload of *swSlotsPtr after strh
 * - chFlags: ss += 0x10 then ss += chOff (two separate increments of r1 in place)
 *   matches "adds r1, #16; adds r1, r1, r4; ldr/str [r1]"
 */
u32 sub_0802DE24(u32 handle, u16 value)
{
    register SoundSystem *ss asm("r1");
    u32 chOff;
    u16 val;
    u16 valCopy;
    u32 idx;
    void **slotTable;
    u32 old;
    u8 *new_var;
    u8 *p;

    if (handle == 0)
        return 0;
    val = value;
    valCopy = val;
    idx = (handle >> 16) & 0xff;
    ss = gpSoundSystem;
    chOff = 0x90;
    chOff <<= 1;
    slotTable = *(void ***)((u8 *)ss + chOff);
    chOff = idx << 2;
    if ((u32)slotTable[idx] != handle)
        return 0;
    if (idx == 3)
        return 0;

    if ((s32)idx <= 2) {
        p = (u8 *)ss + idx * 36;
        old = *(u16 *)(p + 0x20);
        *(u16 *)(p + 0x20) = val;
        ss = (SoundSystem *)((u8 *)ss + 0x10);
        ss = (SoundSystem *)((u8 *)ss + chOff);
        *(u32 *)ss |= SOUND_FLAG_ENV_DIRTY;
    } else {
        u32 adj;
        register SoundSlotAcc **swSlotsPtr asm("r1");
        SoundSlotAcc *swSlots;

        adj = idx - 4;
        swSlotsPtr = (SoundSlotAcc **)((u8 *)ss + SOUND_SYSTEM_SW_SLOTS_OFFSET);
        swSlots = *swSlotsPtr;
        adj <<= 6;
        new_var = (u8 *)((u32)adj + (u32)swSlots);
        old = *(u16 *)new_var;
        *(u16 *)new_var = valCopy;
        swSlots = *swSlotsPtr;
        adj = (u32)((u8 *)((u32)adj + (u32)swSlots));
        *(u32 *)((u8 *)adj + 0x38) |= SOUND_FLAG_ENV_DIRTY;
    }
    return old;
}
