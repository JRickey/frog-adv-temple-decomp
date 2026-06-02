#include "types.h"

typedef struct SoundRngState {
    u8 _pad00[4];
    u32 seed;
} SoundRngState;

#define gpSoundSystem (*(SoundRngState **)0x030065e0)

u32 __umodsi3(u32 dividend, u32 divisor);

void sub_0802E380(u8 *dst, u32 len)
{
    u32 zero;

    if (len != 0) {
        zero = 0;
        do {
            *dst = zero;
            dst++;
            len--;
        } while (len != 0);
    }
}

void sub_0802E394(u8 *dst, u8 *src, u32 len)
{
    u8 *out;

    out = dst;
    if (len != 0) {
        do {
            *out = *src;
            src++;
            out++;
            len--;
        } while (len != 0);
    }
}

u32 sub_0802E3AC(void)
{
    SoundRngState *ss;
    u32 seed;

    ss = gpSoundSystem;
    seed = ss->seed * 0xA8351D63;
    ss->seed = seed;
    return (seed << 11) >> 17;
}

u32 sub_0802E3C8(u32 arg)
{
    SoundRngState *ss;
    u32 value;
    u32 limit;

    limit = (u16)arg;
    ss = gpSoundSystem;
    value = ss->seed * 0xA8351D63;
    ss->seed = value;
    value = (value << 10) >> 16;
    if (value > limit) {
        value = __umodsi3(value, limit);
        value = (u16)value;
    }
    return value;
}
