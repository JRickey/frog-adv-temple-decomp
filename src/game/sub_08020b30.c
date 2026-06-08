#include "types.h"
#include "sound.h"

/* Called once from Init1. Sets bits 0+1 of `flags` and writes a small
 * three-byte constant block (0xCD, 0xF5, 0xF5) into bytes 1..3.
 *
 * The local pointer `p` is necessary for matching: it forces agbcc to
 * emit the base-address `ldr r2, =0x03003570` before the constant-1
 * `movs r0, #1`. Without it the constant load floats ahead, breaking
 * the byte match.
 */
void SoundMixer_Init(void)
{
    SoundState *p = &gSoundState;
    u8 t;

    t = 1;
    t |= p->flags;
    t |= 2;
    p->flags = t;
    p->_field_02 = 0xF5;
    p->masterVolume = 0xCD;
    p->channelDepth = 0xF5;
}

extern void Sound_DrainActiveSlots(void);
extern void SoundRequest_Drain(u32 a);

void SoundMixer_Stop(void)
{
    Sound_DrainActiveSlots();
    SoundRequest_Drain(1);
}
