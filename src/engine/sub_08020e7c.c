#include "sound.h"
#include "types.h"

extern u8 gIwram_3570;

extern u32 SoundHandle_Retire(u32 handle);

void SoundEntry_Stop(u8 idx)
{
    SoundState *p = (SoundState *)&gIwram_3570;
    SoundHandle_Retire(p->entries[idx].fieldB);
}
