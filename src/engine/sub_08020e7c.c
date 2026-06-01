#include "types.h"

typedef struct {
    s32 fieldA;
    u32 fieldB;
} SoundChannelEntry;

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
    SoundChannelEntry entries[12];
} StructAt3003570;

extern u8 gIwram_3570;

extern u32 sub_0802E100(u32 handle);

void sub_08020E7C(u8 idx)
{
    StructAt3003570 *p = (StructAt3003570 *)&gIwram_3570;
    sub_0802E100(p->entries[idx].fieldB);
}
