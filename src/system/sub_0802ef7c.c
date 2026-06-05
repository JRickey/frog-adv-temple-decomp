#include "sound.h"
#include "macros.h"

void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)
{
    register u32 cf asm("r2");
    register u32 cfReload asm("ip");
    register SoundSystem **pp asm("r3");
    register SoundSystem **ppReload asm("r8");
    register SoundSystem **ppFinal asm("r1");
    SoundSystem *ss1;
    register SoundSystem *ss2 asm("r3");
    SoundSystem *ss3;
    SoundSlot *slot;
    u32 flags;
    register u32 newFlags asm("r0");

    if (channel > 3)
        goto sw_slot;

    pp = &gpSoundSystem;
    ss1 = *pp;
    cf = (u32)(channel << 2);
    {
        u8 *flagp;

        flagp = (u8 *)ss1;
        flagp += SOUND_CH_FLAGS_OFFSET;
        flagp += cf;
        flags = *(u32 *)flagp;
    }
    flags &= SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    ppReload = pp;
    cfReload = cf;
    if (flags == 0) {
        u8 *accp;
        register s16 accReset asm("r1");

        accp = (u8 *)ss1 + (channel << 3);
        accReset = 0;
        if (clearAcc == 0) {
            cf = 0xff;
            cf <<= 8;
            accReset = cf;
        }
        *(u16 *)(accp + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    }

    ss2 = *ppReload;
    {
        register u32 *flagp asm("r2");

        flagp = (u32 *)((u8 *)ss2 + SOUND_CH_FLAGS_OFFSET);
        flagp = (u32 *)((u8 *)flagp + cfReload);
        newFlags = *flagp;
        newFlags &= SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE;
        newFlags |= SOUND_FLAG_ENVELOPE_C_INACTIVE;
        *flagp = newFlags;
    }
    ss2 = (SoundSystem *)((u8 *)ss2 + SOUND_ENVELOPE_C_CHANNEL_BASE);
    ss2 = (SoundSystem *)((u8 *)ss2 + (channel << 3));
    *(s32 *)ss2 = value;
    if (clearAcc == 0)
        *(s32 *)ss2 = -(s32)value;

    ppFinal = ppReload;
    ss3 = *ppFinal;
    {
        u8 *accp;
        register s16 accReset asm("r1");

        accp = (u8 *)ss3 + (channel << 3);
        accReset = 0;
        if (clearAcc == 0) {
            cf = 0xff;
            cf <<= 8;
            accReset = cf;
        }
        *(u16 *)(accp + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    }
    return;

sw_slot:
    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, channel);
    newFlags = slot->flags;
    flags = SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    newFlags &= flags;
    if (newFlags == 0) {
        register s16 accReset asm("r0");
        register u32 high asm("r1");

        accReset = 0;
        if (clearAcc == 0) {
            high = 0xff;
            high <<= 8;
            accReset += high;
        }
        SOUND_SLOT_ENVELOPE_C(slot)->acc = accReset;
    }

    newFlags = slot->flags;
    newFlags &= SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE;
    newFlags |= SOUND_FLAG_ENVELOPE_C_INACTIVE;
    slot->flags = newFlags;
    SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = value;
    if (clearAcc == 0)
        SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = -(s32)value;
}
