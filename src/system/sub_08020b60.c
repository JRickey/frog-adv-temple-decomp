#include "types.h"

extern void Sound_DrainActiveSlots(void);
extern void SoundChannel_BroadcastValue(u32 a);
extern void SoundRequestSlot_Drain(u32 a);
extern u32 SoundSlot_ClearInProgress(void);

void SoundSystem_StopAll(void)
{
    Sound_DrainActiveSlots();
    SoundChannel_BroadcastValue(0);
    SoundRequestSlot_Drain(1);
}

void SoundSystem_FadeOut(void)
{
    SoundChannel_BroadcastValue(45);
    SoundSlot_ClearInProgress();
}
