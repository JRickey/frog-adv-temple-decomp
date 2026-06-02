#include "types.h"

typedef struct SoundSystemTail {
    u8 _pad00[8];
    u32 flags;
    u16 field_0c;
    u16 field_0e;
    u8 _pad10[0xe4];
    u32 field_f4;
    u8 _padf8[0x16];
    u8 field_10e;
} SoundSystemTail;

#define gpSoundSystem       (*(SoundSystemTail **)0x030065e0)
#define REG_SOUNDCNT_L_LOW  (*(vu8 *)0x04000080)
#define REG_SOUNDCNT_L_HIGH (*(vu8 *)0x04000082)

void sub_0802E27C(u32 arg)
{
    if (arg == 0) {
        gpSoundSystem->field_10e = arg;
        return;
    }

    gpSoundSystem->field_10e = gpSoundSystem->field_f4 != 0;
}

u32 sub_0802E2B4(void)
{
    return gpSoundSystem->flags;
}

u32 sub_0802E2C0(u32 flags)
{
    SoundSystemTail *ss;
    u32 result;

    ss = gpSoundSystem;
    result = ss->flags ^ flags;
    ss->flags = flags;
    return result;
}

u32 sub_0802E2D4(u32 bit)
{
    u32 result;

    result = gpSoundSystem->flags & (1 << bit);
    if (result != 0)
        result = 1;
    return result;
}

u32 sub_0802E2EC(u32 bit)
{
    SoundSystemTail *ss;
    u32 mask;
    u32 old;
    u32 result;

    mask = 1 << bit;
    ss = gpSoundSystem;
    old = ss->flags;
    ss->flags = old | mask;
    result = old & mask;
    if (result != 0)
        result = 1;
    return result;
}

u32 sub_0802E30C(u32 bit)
{
    SoundSystemTail *ss;
    u32 mask;
    u32 old;
    u32 result;

    mask = 1 << bit;
    ss = gpSoundSystem;
    old = ss->flags;
    ss->flags = old & ~mask;
    result = old & mask;
    if (result != 0)
        result = 1;
    return result;
}

void sub_0802E32C(u32 arg)
{
    SoundSystemTail *ss;
    u32 value;

    value = (u8)arg;
    ss = gpSoundSystem;
    ss->field_0c = value;
    if (value != 0)
        ss->field_0c = value + 1;
}

void sub_0802E344(u32 arg)
{
    SoundSystemTail *ss;
    u32 value;

    value = (u8)arg;
    ss = gpSoundSystem;
    ss->field_0e = value;
    if (value != 0)
        ss->field_0e = value + 1;
}

void sub_0802E35C(u32 arg)
{
    u32 value;

    value = (u8)arg;
    REG_SOUNDCNT_L_HIGH = value;
}

void sub_0802E36C(u32 arg)
{
    u32 value;

    value = (u8)arg;
    REG_SOUNDCNT_L_LOW = value & 0x77;
}
