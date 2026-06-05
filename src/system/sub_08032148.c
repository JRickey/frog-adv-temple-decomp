#include "sound.h"

u8 sub_08032148(void)
{
    SoundRequestSlot *slot = gpSoundSystem->slot;
    u32 active = slot->flags & SOUND_REQUEST_FLAG_ACTIVE;
    SoundSystem **gpsp = &gpSoundSystem;
    SoundSystem **gpsp2;
    SoundDrainEntry *drain;
    s32 i;
    s32 limit;
    s32 limit2;
    s32 acc;

    if (active) {
        for (i = 0; i < SOUND_REQUEST_STREAM_COUNT; i++) {
            if (slot->timers[i].cursor != NULL)
                return 1;

            if (slot->streams[i].cursor != NULL)
                return 1;
        }
    }

    i = 0;
    limit = (s32)(*gpsp)->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT;
    if (i < limit) {
        drain = SOUND_REQUEST_DRAIN_ENTRIES(slot);
        gpsp2 = gpsp;
        limit2 = limit;
        do {
            if (drain[i].live != 0)
                return 1;

            if ((*gpsp2)->channelSeqs[i].opPtr != NULL) {
                if (i <= SOUND_REQUEST_LEADIN_CHANNEL_MAX) {
                    acc = (*gpsp2)->chanAcc[i];
                    if (acc <= SOUND_MIX_BYTE_MASK)
                        goto found;
                } else {
                    acc = SOUND_SYSTEM_SW_SLOT(*gpsp2, i - SOUND_REQUEST_DRAIN_EXTRA_COUNT)->accA;
                    if (acc > SOUND_MIX_BYTE_MASK)
                        goto cont;
                found:
                    return 1;
                }
            }

        cont:
            i++;
        } while (i < limit2);
    }

    return 0;
}
