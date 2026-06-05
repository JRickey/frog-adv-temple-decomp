#include "sound.h"

enum SoundDrainMode {
    SOUND_DRAIN_MODE_CLEAR = 0,
    SOUND_DRAIN_MODE_RETIRE = 1,
};

extern void sub_0802F9F0(u32 idx);
extern void sub_0802E724(s32 channel);

u32 sub_08031FDC(u32 mode)
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
                            sub_0802F9F0(i);
                        } else {
                            gpSoundSystem->channelSeqs[i].opPtr = (u32 *)zero;
                            sub_0802E724(i);
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
