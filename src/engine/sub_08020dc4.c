#include "types.h"
#include "iwram.h"

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

extern u32 sub_0802E184(u32 handle);
extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void sub_0802DC1C(u32 handle, u8 val);

/* Keep this base opaque so agbcc does not fold the entries field offsets into separate IWRAM literals. */
void sub_08020DC4(u8 idx)
{
    StructAt3003570 *p = (StructAt3003570 *)&gIwram_3570;
    u32 sound;
    u32 handle;

    if (sub_0802E184(p->entries[idx].fieldB) != 0)
        return;

    sound = p->entries[idx].fieldA;
    handle = -1;
    if ((p->flags & 0x10) != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
        sub_0802DC1C(handle, p->c & 0x7f);
    }
    p->entries[idx].fieldB = handle;
}

extern u8 sub_08021E34(struct IwramAt3720 *s, u8 halfW, u8 halfH);

void sub_08020E14(struct IwramAt3720 *s, u8 idx, u8 halfW, u8 halfH)
{
    StructAt3003570 *p;
    u32 sound;
    u32 handle;

    if (sub_08021E34(s, halfW, halfH) == 0)
        return;

    p = (StructAt3003570 *)&gIwram_3570;
    if (sub_0802E184(p->entries[idx].fieldB) != 0)
        return;

    sound = p->entries[idx].fieldA;
    handle = -1;
    if ((p->flags & 0x10) != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
        sub_0802DC1C(handle, p->c & 0x7f);
    }
    p->entries[idx].fieldB = handle;
}
