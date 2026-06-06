#include "types.h"

extern void SoundEnvelope_SetRamp(u32 a, s16 b, u16 c, u32 d);

u32 SoundOp_SetEnvelopeRamp(u32 arg0, u8 **cursor)
{
    u8 *ptr = *cursor;

    SoundEnvelope_SetRamp(ptr[1] & 1, *(s16 *)(ptr + 2), *(u16 *)(ptr + 4), arg0);
    *cursor += 6;
    return 1;
}
