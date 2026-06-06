#include "sound.h"

enum SoundDrainMode {
    SOUND_DRAIN_MODE_CLEAR = 0,
    SOUND_DRAIN_MODE_RETIRE = 1,
};

extern void Sound_RetireChannel(u32 idx);
extern void SoundChannel_Reset(s32 channel);

u32 SoundRequest_Drain(u32 mode)
{
    SoundSystem **soundSystemPtr = &gpSoundSystem;
    SoundSystem *soundSystem = *soundSystemPtr;
    SoundRequestSlot *request = soundSystem->slot;
    SoundSystem **poolPtr;
    u8 **drainBase;
    SoundDrainEntry *drain;
    u8 flags = request->flags;
    /* r0 matches the ROM's cleared-flags AND result before storing request->flags. */
    register u8 clearedFlags asm("r0");
    s32 i;
    s32 byteOffset;
    u32 zero;

    i = flags & SOUND_REQUEST_FLAG_READY_MASK;
    poolPtr = soundSystemPtr;

    if (i == SOUND_REQUEST_FLAG_READY_MASK) {
        clearedFlags = flags & ~SOUND_REQUEST_FLAG_READY_MASK;
        request->flags = clearedFlags;

        if (mode != SOUND_DRAIN_MODE_CLEAR) {
            i = 0;
            if (i < (s32)(*poolPtr)->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT) {
                drainBase = &request->nextRegion;
                byteOffset = 0;
                zero = 0;

                do {
                    drain = (SoundDrainEntry *)(byteOffset + (u32)*drainBase);
                    if (drain->live != 0) {
                        if (mode == SOUND_DRAIN_MODE_RETIRE) {
                            Sound_RetireChannel(i);
                        } else {
                            gpSoundSystem->channelSeqs[i].opPtr = (u32 *)zero;
                            SoundChannel_Reset(i);
                        }

                        drain = (SoundDrainEntry *)(byteOffset + (u32)*drainBase);
                        drain->live = zero;
                        poolPtr = &gpSoundSystem;
                    }
                    byteOffset += sizeof(SoundDrainEntry);
                    i++;
                } while (i < (s32)(*poolPtr)->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT);
            }
        }

        (*poolPtr)->startIndex = 0;
        return 1;
    }

    return 0;
}
