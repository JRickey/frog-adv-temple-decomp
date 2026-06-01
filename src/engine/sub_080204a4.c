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

typedef struct {
    u8 _pad00[10];
    u8 mode;
} StructAt3005330;

#define gStructAt3005330 (*(StructAt3005330 *)0x03005330)

extern u8 gIwram_3570;

extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void sub_0802DC1C(u32 handle, u8 val);
extern u32 sub_0802E100(u32 handle);
extern u32 sub_0802E184(u32 handle);

void sub_080204A4(u8 tile)
{
    StructAt3003570 *p;
    StructAt3003570 *slotBase;
    StructAt3003570 *stopBase;
    StructAt3003570 *stopSlotBase;
    u32 sound;
    u32 handle;
    u32 pan;

    switch (tile) {
    case 5:
    case 7:
    case 26:
    case 27:
        goto startSlot0;

    case 6:
    case 24:
        goto startSlot1;

    case 31:
        if (gStructAt3005330.mode != 1)
            return;
        goto startSlot0;

    default:
        goto stopSlots;
    }

startSlot1:
    p = (StructAt3003570 *)&gIwram_3570;
    slotBase = (StructAt3003570 *)((u8 *)p + 8);
    if (sub_0802E184(slotBase->entries[0].fieldB) != 0)
        return;

    sound = p->entries[1].fieldA;
    handle = -1;
    if ((p->flags & 0x10) != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
        pan = 0x7f;
        p = (StructAt3003570 *)(u32)p->c;
        pan &= (u32)p;
        sub_0802DC1C(handle, pan);
    }
    slotBase->entries[0].fieldB = handle;
    return;

startSlot0:
    p = (StructAt3003570 *)&gIwram_3570;
    if (sub_0802E184(p->entries[0].fieldB) != 0)
        return;

    sound = p->entries[0].fieldA;
    handle = -1;
    if ((p->flags & 0x10) != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
        pan = 0x7f;
        pan &= p->c;
        sub_0802DC1C(handle, pan);
    }
    p->entries[0].fieldB = handle;
    return;

stopSlots:
    stopBase = (StructAt3003570 *)&gIwram_3570;
    stopSlotBase = (StructAt3003570 *)((u8 *)stopBase + 8);
    sub_0802E100(stopBase->entries[0].fieldB);
    sub_0802E100(stopSlotBase->entries[0].fieldB);
    return;
}
