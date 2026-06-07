#include "sound.h"

extern u32 __udivsi3(u32 num, u32 den);

void SoundSlot_CalcStreamTiming(void)
{
    SoundSystem *ss = gpSoundSystem;
    SoundRequestSlot *slot = ss->slot;
    u32 pv;
    u32 t;
    u32 t1;

    pv = slot->pendingValue;
    /* t1 = pv<<8 saved before the in-place t = pv<<9 shift so agbcc emits
     * lsls r1,r0,#8 (non-destructive) then lsls r0,r0,#9 then adds r0,r0,r1 */
    t1 = pv << 8;
    t = pv << 9;
    t += t1;
    t <<= 5;
    slot->samplesThisFrame = (u16)((__udivsi3(t, 3600) * slot->pendingId) >> 12);

    pv = slot->pendingValue;
    t = (pv * 3) << 17;
    slot->streamLeadIn = (u16)(__udivsi3(__udivsi3(t, (u32)ss->divisor * 5) << 12, slot->pendingId));
}
