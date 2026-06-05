#include "sound.h"

/* sub_08032094 — drain/retire the active sound-request slot.
 *
 * Companion to sub_08031FDC: only acts when the request slot's 3-bit state
 * field (flags & 7) is 3, in which case it clears the ACTIVE bit, sets the
 * drained bit (0x4), and (unless mode is CLEAR) walks every drain entry
 * (count + 4 of them, re-read from gpSoundSystem each pass) retiring the
 * live ones — RETIRE mode hands each index to sub_0802F9F0, otherwise it
 * nulls the channel sequencer's opcode pointer and silences the channel via
 * sub_0802E724.
 *
 * Matching note: &gpSoundSystem stays in ip across the loop and is
 * re-materialized after each BL (ip is call-clobbered). This falls out of a
 * plain `SoundSystem **poolPtr` local with NO register pin — pinning poolPtr
 * to ip turns the per-iteration ip->low move into an allocator copy instead
 * of a reload, which desyncs reload's round-robin spill-register choice and
 * mis-colors the in-loop scratch constants.
 */

enum SoundDrainMode {
    SOUND_DRAIN_MODE_CLEAR = 0,
    SOUND_DRAIN_MODE_RETIRE = 1,
};

extern void sub_0802F9F0(s32 idx);
extern void sub_0802E724(s32 channel);

u32 sub_08032094(u32 mode)
{
    SoundSystem **poolPtr;
    SoundRequestSlot *request;
    u8 flags;
    u32 state;
    u32 newFlags;
    s32 i;

    request = gpSoundSystem->slot;
    flags = request->flags;
    state = flags & 7;
    poolPtr = &gpSoundSystem;

    if (state == 3) {
        newFlags = (u8)~SOUND_REQUEST_FLAG_ACTIVE;
        newFlags &= flags;
        newFlags |= 4;
        request->flags = newFlags;

        if (mode != SOUND_DRAIN_MODE_CLEAR) {
            for (i = 0;; i++) {
                if (i >= (s32)(*poolPtr)->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT)
                    break;
                if (SOUND_REQUEST_DRAIN_ENTRIES(request)[i].live == 0)
                    continue;
                if (mode == SOUND_DRAIN_MODE_RETIRE) {
                    sub_0802F9F0(i);
                } else {
                    gpSoundSystem->channelSeqs[i].opPtr = NULL;
                    sub_0802E724(i);
                }
                SOUND_REQUEST_DRAIN_ENTRIES(request)[i].live = 0;
                poolPtr = &gpSoundSystem;
            }
        }
        return 1;
    }
    return 0;
}
