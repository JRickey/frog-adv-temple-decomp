#include "types.h"

/* Increments the offset-3 counter byte in the sound-channel struct at
 * 0x03003570 and forwards the caller's byte argument plus the new counter
 * value into SoundHandle_SetPan. Bails out without calling once the counter has
 * saturated at 245. Sibling Sound_DecrementChannelDepth is the matching decrement. */

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern void SoundHandle_SetPan(u8 value, u8 counter);

void Sound_IncrementChannelDepth(u8 value)
{
    StructAt3003570 *p = &gStructAt3003570;

    if (p->d > 244) {
        return;
    }
    p->d++;
    SoundHandle_SetPan(value, p->d);
}
