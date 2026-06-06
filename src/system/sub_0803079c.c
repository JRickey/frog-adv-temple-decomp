#include "sound.h"
#include "macros.h"

typedef struct SoundInlineAcc1ElementView {
    u8 _pad00[0x22];
    u16 acc1;
} SoundInlineAcc1ElementView;

typedef struct SoundInlineAcc1View {
    SoundInlineAcc1ElementView inlineAcc1[SOUND_INLINE_CHANNEL_COUNT];
} SoundInlineAcc1View;

/* SoundOp_SetPitchRel — stream opcode handler. Programs a channel's acc1 "step"
 * from a 16-bit operand relative to the channel's current acc0, then flags
 * the channel's envelope dirty (SOUND_FLAG_ENV_DIRTY).
 *
 *   channel 0..2 -> ss->inlineChannels[channel]; the dirty bit lives in
 *                   ss->chFlags[channel].
 *   channel 4..N -> ss->swSlots[channel-4];      the dirty bit lives in
 *                   slot->flags (+0x38).
 *   channel 3    -> no-op fall-through.
 *
 * One of a family of (channel, state_ptr) opcode handlers; this one
 * consumes a 4-byte command and advances *state_ptr past it. The acc0/acc1
 * pair sits at offsets +0/+2 of both the 36-byte inline channel and the
 * 64-byte sw slot, so both branches reach them as raw u16 stores. */
s32 SoundOp_SetPitchRel(s32 channel, u32 *state_ptr)
{
    u8 *stream;

    stream = (u8 *)*state_ptr;

    if (channel <= 2) {
        SoundSystem *ss;
        u8 *ic;

        ss = gpSoundSystem;
        ic = (u8 *)ss + channel * SOUND_INLINE_CHANNEL_STRIDE;
        *(u16 *)(ic + 0x22) = *(u16 *)(stream + 2) - *(u16 *)(ic + 0x20);
        ss->chFlags[channel] |= SOUND_FLAG_ENV_DIRTY;
    } else if (channel > 3) {
        u8 *slot;

        slot = (channel * SOUND_SW_SLOT_STRIDE - 0x100) + (u8 *)gpSoundSystem->swSlots;
        *(u16 *)(slot + 2) = *(u16 *)(stream + 2) - *(u16 *)slot;
        *(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) |= SOUND_FLAG_ENV_DIRTY;
    }

    *state_ptr += 4;
    return 1;
}

s32 SoundOp_SetAcc1(s32 channel, u32 *state_ptrArg)
{
    u32 *state_ptr;
    u8 *stream;

    state_ptr = state_ptrArg;
    stream = (u8 *)*state_ptr;

    if (channel <= 2) {
        SoundSystem **pPool;

        if (stream[1] & 1) {
            ((SoundInlineAcc1View *)gpSoundSystem)->inlineAcc1[channel].acc1 = *(u16 *)(stream + 2);
            pPool = &gpSoundSystem;
        } else {
            ((SoundInlineAcc1View *)gpSoundSystem)->inlineAcc1[channel].acc1 += *(u16 *)(stream + 2);
            pPool = &gpSoundSystem;
        }
        (*pPool)->chFlags[channel] |= SOUND_FLAG_ENV_DIRTY;
    } else if (channel > 3) {
        u8 *slot;

        slot = (channel * SOUND_SW_SLOT_STRIDE - 0x100) + (u8 *)gpSoundSystem->swSlots;
        if (stream[1] & 1) {
            *(u16 *)(slot + 2) = *(u16 *)(stream + 2);
        } else {
            *(u16 *)(slot + 2) += *(u16 *)(stream + 2);
        }
        *(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) |= SOUND_FLAG_ENV_DIRTY;
    }

    *state_ptr += 4;
    return 1;
}
