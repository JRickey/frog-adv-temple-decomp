#include "sound.h"
#include "types.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
    SoundChannelEntry entries[12];
} StructAt3003570;

extern u8 gIwram_3570;

extern u32 SoundHandle_Retire(u32 handle);

void SoundEntry_Stop(u8 idx)
{
    StructAt3003570 *p = (StructAt3003570 *)&gIwram_3570;
    SoundHandle_Retire(p->entries[idx].fieldB);
}
