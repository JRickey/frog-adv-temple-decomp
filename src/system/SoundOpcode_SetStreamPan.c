#include "sound.h"

extern void Sound_MarkChannelFullDirty(s32 idx);

u32 SoundOpcode_SetStreamPan(s32 channelIdx, u8 **cursor)
{
    u8 *ptr = *cursor;

    Sound_MarkChannelFullDirty(channelIdx);

    if (channelIdx > 3) {
        SoundSystem *ss = gpSoundSystem;
        if (*((u8 *)ss + SOUND_SYSTEM_STREAM_PAN_BYTE_OFFSET) != 0) {
            SoundMixEntry *mixTable = ss->mixTable;
            /* Cast to u32 before adding keeps the offset in r0 and mixTable in
             * r1 so agbcc emits `adds r0, r0, r1; adds r1, r0, #0` to match
             * the baserom. */
            u8 *entry = (u8 *)((u32)(channelIdx * 28) + (u32)mixTable) - 4 * 28;
            entry[0x1B] = ptr[1] == 0 ? 1 : 0;
        }
    }

    *cursor += 2;
    return 1;
}
