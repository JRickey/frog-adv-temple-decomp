#include "sound.h"

/* Sound_OpenStream — start a streaming sound channel.
 *
 * channel:    one of 4 stream channels (0..3); fails if already active.
 * generator:  generator function pointer stored in channelWork[channel].
 * lengthFp:   stream length in 12.4 fixed point, divided by the system
 *             divisor to derive the per-channel period.
 * loopLength: loop length forwarded to the slot initializer.
 * arg4:       extra word forwarded to the slot initializer.
 * useMutePan: when nonzero, the mix entry's pan byte is seeded from the
 *             system stream-pan byte (+0x10e) instead of 0.
 *
 * Reserves a SW slot via SoundSlot_PickByPriority, primes it with
 * SoundSlot_InitParams, installs it in the slot table, then runs the generator once
 * to fill the first run and seeds the mix entry before committing the slot's
 * pan with SoundPan_UpdateMixEntry.
 *
 * Returns a packed handle (active bit | slotIdx << 16 | channel) on success,
 * 0 on failure.
 */

typedef s32 (*SoundGenerator)(s32 count, u32 *outStart, u32 *outFlag, u32 *outExtra, u32 channel);

typedef struct StreamMixEntry {
    u32 word00;
    u32 outStart; /* +0x04 */
    u32 outEnd;   /* +0x08 */
    u32 word0c;
    u32 word10;
    u16 period; /* +0x14 */
    u16 work;   /* +0x16 */
    u8 _pad18[3];
    u8 panByte; /* +0x1b */
} StreamMixEntry;

extern s32 SoundSlot_PickByPriority(s32 mode, u32 priority, s32 a2, s32 idx);
extern void SoundSlot_InitParams(SoundSlotInit *slot, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
extern void SoundPan_UpdateMixEntry(s32 index);

u32 Sound_OpenStream(u32 channel, u32 generator, u32 lengthFp, u32 loopLength, u32 arg4, u32 useMutePan)
{
    SoundSystem *ss;
    u32 *work;
    u32 workValue;
    s32 slotIdx;
    SoundSlotInit *slot;
    StreamMixEntry *mix;
    u16 period;
    s32 count;
    s32 produced;
    u32 outStart;
    u32 outFlag;
    u32 outExtra;

    if ((s32)channel > 3)
        goto fail;

    work = &SOUND_SYSTEM_CHANNEL_WORK(gpSoundSystem)[channel];
    workValue = *work;
    if (workValue != 0)
        goto fail;

    slotIdx = SoundSlot_PickByPriority(1, SOUND_STREAM_PRIORITY, 0xff, 0xff);
    if (slotIdx < 0)
        goto fail;

    {
        SoundSystem *ss1 = gpSoundSystem;
        ((u32 *)ss1->auxTable)[slotIdx] = workValue;
        slot = (SoundSlotInit *)((u8 *)ss1->swSlots + slotIdx * SOUND_SW_SLOT_STRIDE);
    }

    SoundSlot_InitParams(slot, 0, arg4, loopLength, SOUND_STREAM_PRIORITY);
    slot->flags |= SOUND_SLOT_FLAG_STREAM_PRIME;
    *((u8 *)slot + 0x3e) = channel;

    {
        SoundSystem *ss1 = gpSoundSystem;
        ss1->slotPtrTable[slotIdx] = (SoundSlot *)slot;
        *work = generator;
        period = (lengthFp << 12) / ss1->divisor;
    }
    count = (period >> 5) + 2;

    produced = ((SoundGenerator)*work)(count, &outStart, &outFlag, &outExtra, channel);

    ss = gpSoundSystem;
    mix = (StreamMixEntry *)((u8 *)ss->mixTable + slotIdx * SOUND_STREAM_MIX_ENTRY_STRIDE);
    mix->period = period;
    mix->work = workValue;

    {
        u8 panByte;
        if (useMutePan != 0)
            panByte = *((u8 *)ss + SOUND_SYSTEM_STREAM_PAN_BYTE_OFFSET);
        else
            panByte = 0;
        mix->panByte = panByte;
        mix->word00 = 0;
    }
    mix->outStart = outStart;
    mix->outEnd = outStart + produced;
    mix->word0c = 0;
    mix->word10 = 0;

    SoundPan_UpdateMixEntry(slotIdx);

    return SOUND_STREAM_HANDLE(slotIdx, channel);

fail:
    return 0;
}
