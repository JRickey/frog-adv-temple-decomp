#include "types.h"

extern void SoundEnvelope_SetOscillator(s16 a, u8 b, u32 c);

u32 SoundOp_SetEnvelopeOscillator(u32 arg0, u8 **cursor)
{
    u8 *ptr = *cursor;

    SoundEnvelope_SetOscillator(*(s16 *)(ptr + 2), ptr[1], arg0);
    *cursor += 4;
    return 1;
}
