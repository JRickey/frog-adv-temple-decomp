#include "sound.h"
#include "macros.h"

extern void sub_0802F398(s32 index);
extern void sub_0802FA60(s32 index);

void sub_080308B0(s32 index, u32 sampleId, u32 startOffset, u32 mode)
{
    SoundSystem **gpsp;
    u32 lengthCopy;
    unsigned long long zeroWide;
    SoundSystem *ss;
    u8 *slot;
    u8 *entry;
    SoundSystem **gpspCopy;
    u8 *bank;
    u8 *desc;
    u8 *cur;
    u32 length;
    s32 loopStart;

    gpsp = &gpSoundSystem;
    ss = *gpsp;

    slot = (u8 *)ss->swSlots + index * SOUND_SW_SLOT_STRIDE;
    entry = (u8 *)ss->mixTable + index * SOUND_STREAM_MIX_ENTRY_STRIDE;

    ((u32 *)ss->auxTable)[index] = 0;
    *(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) =
        (*(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) & 0xffffb3ff) | SOUND_STREAM_PRIORITY;

    bank = SOUND_SYSTEM_SAMPLE_BANK(ss);
    desc = bank + ((u32 *)(bank + *(u32 *)(bank + 0x1c)))[sampleId];

    *(u8 **)(entry + 0) = desc;
    cur = desc + 0x10;
    *(u8 **)(entry + 4) = cur;
    length = *(u32 *)desc;
    *(u8 **)(entry + 8) = cur + length;
    gpspCopy = &(*gpsp);

    loopStart = *(s32 *)(desc + 4);
    if (loopStart < 0) {
        *(u32 *)(entry + 12) = 0;
        *(u32 *)(entry + 16) = 0;
    } else {
        *(u8 **)(entry + 12) = cur + loopStart;
        lengthCopy = length;
        *(u32 *)(entry + 16) = lengthCopy - loopStart;
    }

    if (startOffset != 0) {
        u8 *base;
        u8 *advanced;

        base = *(u8 **)(entry + 4);
        advanced = base + startOffset;
        if (advanced < *(u8 **)(entry + 8))
            *(u8 **)(entry + 4) = advanced;
    }

    {
        u16 zeroH;
        u8 zeroB;

        zeroH = 0;
        zeroWide = zeroH;
        zeroB = 0;
        *(u16 *)(entry + 22) = zeroWide;
        *(u8 *)(entry + 26) = zeroB;
    }
    {
        u8 pan;

        if (*(u8 *)(slot + 0x3d) != 0)
            pan = *(u8 *)((u8 *)*gpspCopy + SOUND_SYSTEM_STREAM_PAN_BYTE_OFFSET);
        else
            pan = 0;
        *(u8 *)(entry + 27) = pan;
    }

    sub_0802F398(index);
    if (mode == 0) {
        sub_0802FA60(index);
    } else {
        u16 prio;

        prio = SOUND_STREAM_PRIORITY;
        *(u16 *)(entry + 20) = prio;
        *(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) &= ~SOUND_FLAG_ENV_DIRTY;
    }
}
