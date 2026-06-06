#include "types.h"

extern u32 SoundSystem_IsActive(void);
extern void SoundRequest_Drain(u32 a);

void Sound_DrainIfActive(void)
{
    if (SoundSystem_IsActive()) {
        SoundRequest_Drain(1);
    }
}
