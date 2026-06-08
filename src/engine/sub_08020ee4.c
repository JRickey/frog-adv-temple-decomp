#include "types.h"
#include "sound.h"

/* Increments the offset-3 counter byte in the sound-channel struct at
 * 0x03003570 and forwards the caller's byte argument plus the new counter
 * value into SoundHandle_SetPan. Bails out without calling once the counter has
 * saturated at 245. Sibling Sound_DecrementChannelDepth is the matching decrement. */

extern void SoundHandle_SetPan(u8 value, u8 counter);

void Sound_IncrementChannelDepth(u8 value)
{
    SoundState *p = &gSoundState;

    if (p->channelDepth > 244) {
        return;
    }
    p->channelDepth++;
    SoundHandle_SetPan(value, p->channelDepth);
}
