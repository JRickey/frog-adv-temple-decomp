#include "types.h"

#define gpSoundSystem (*(u8 **)0x030065e0)

u32 sub_0802E220(u32 handle)
{
    u8 *ss;
    s32 idx;
    u32 *slotTable;
    u32 offset;

    if (handle == 0)
        goto fail;

    idx = (handle >> 16) & 0xff;
    ss = gpSoundSystem;
    slotTable = *(u32 **)(ss + 0x120);
    if (slotTable[idx] != handle)
        goto fail;

    if (idx <= 2) {
        offset = idx * 36;
        return *(u16 *)(ss + offset + 0x20);
    }

    if (idx > 3)
        goto sw_slot;

fail:
    return 0;

sw_slot:
    return *(u16 *)(*(u8 **)(ss + 0xc8) + idx * 64 - 0x100);
}
