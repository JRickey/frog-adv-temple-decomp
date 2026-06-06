#include "sound.h"

/* SoundStream_UpdateCursor — advance a SW-slot's stream cursor by one frame.
 *
 * slotIndex: index into the SW-slot table.
 * cursor:    the stream cursor for that slot.
 *
 * The slot byte at +0x3e selects a per-channel work entry.  When that entry
 * (channelWork[chIdx]) is zero the channel is idle: if the cursor has not yet
 * reached its limit, its output fields are cleared.  When non-zero the entry
 * is a generator function pointer; it is invoked to produce the next run of
 * samples and the cursor's output/limit fields are updated from its results.
 */

typedef struct StreamCursor {
    u32 _pad00;
    u32 readPos;
    u32 writePos;
    u32 outStart;
    u32 outLen;
    u16 rateHi;
    u16 rateLo;
} StreamCursor;

typedef s32 (*SoundGenerator)(s32 count, u32 *outStart, u32 *outFlag, u32 *outExtra, u32 chIdx);

void SoundStream_UpdateCursor(u32 slotIndex, StreamCursor *cursor)
{
    SoundSystem *ss;
    u8 *swSlots;
    u8 *slot;
    u32 *work;
    u32 chIdx;
    s32 remaining;
    s32 produced;
    s32 ret;
    u32 outStart;
    u32 outFlag;
    u32 outExtra;

    ss = gpSoundSystem;

    /* swSlots is cached so the base load precedes the index shift, and the
     * index-first cast keeps the shifted index as the add destination
     * (adds r0, r0, r1 rather than adds r1, r1, r0). */
    swSlots = (u8 *)ss->swSlots;
    slot = (u8 *)((slotIndex << 6) + (u32)swSlots);
    chIdx = slot[0x3e];
    work = &SOUND_SYSTEM_CHANNEL_WORK(ss)[chIdx];

    if (*work == 0) {
        if (cursor->readPos < cursor->writePos) {
            cursor->outStart = 0;
            cursor->outLen = 0;
        }
        return;
    }

    remaining = cursor->writePos - cursor->readPos - 1;
    cursor->outLen = 0;
    cursor->outStart = 0;
    produced = (((cursor->rateHi << 7) + cursor->rateLo + 0xfff) >> 12) - remaining;
    if (produced <= 0)
        return;

    ret = ((SoundGenerator)*work)(produced, &outStart, &outFlag, &outExtra, chIdx);

    if (outFlag == 0) {
        if (outStart + ret < cursor->readPos) {
            cursor->outStart = outStart;
            cursor->outLen = ret;
        } else {
            cursor->writePos = outStart + ret;
        }
    } else {
        cursor->writePos = outStart + outExtra;
        cursor->outStart = outFlag;
        cursor->outLen = ret - outExtra;
    }

    if (ret < produced)
        *work = 0;
}

extern void SoundMixer_VBlankTick(void);
extern void Sound_StartDma(void);

void Sound_SetActiveCount(u8 idx)
{
    SoundSystem *ss = gpSoundSystem;
    u32 oldCount = ss->count;

    if (oldCount == idx)
        return;

    if (idx > ss->slot->numChannels)
        idx = ss->slot->numChannels;

    ss->count = idx;

    if (idx == 0) {
        SoundMixer_VBlankTick();
        return;
    }

    if (oldCount == 0)
        Sound_StartDma();
}
