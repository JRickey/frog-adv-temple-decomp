#include "sound.h"
#include "types.h"
#include "iwram.h"

typedef struct {
    u8 _pad00[10];
    u8 mode;
} StructAt3005330;

#define gStructAt3005330 (*(StructAt3005330 *)0x03005330)

extern u8 gIwram_3570;

extern u32 Sound_AllocVoice(u32 sound, u32 a, u32 b, u32 c);
extern void SoundHandle_SetPan(u32 handle, u8 val);
extern u32 SoundHandle_Retire(u32 handle);
extern u32 SoundHandle_IsActive(u32 handle);
extern u8 Entity_IsInTileRange(struct Entity *s, u8 halfW, u8 halfH);

void Entity_ProximitySound(struct Entity *entity, u8 channel, u8 halfW, u8 halfH)
{
    if (Entity_IsInTileRange(entity, halfW, halfH) != 0) {
        if ((entity->status & 0x2000) != 0)
            return;

        entity->status |= 0x2000;

        {
            SoundState *p;
            u32 offset;
            u32 slot;
            u32 base;
            u32 sound;
            u32 handle;

            p = (SoundState *)&gIwram_3570;
            offset = channel * 8;
            base = (u32)p;
            base += 8;
            slot = offset + base;
            if (SoundHandle_IsActive(*(u32 *)slot) != 0)
                return;

            base = (u32)p;
            base += 4;
            sound = *(u32 *)(offset + base);
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = Sound_AllocVoice(sound, 0xff, 0xff, 0xff);
                SoundHandle_SetPan(handle, p->_field_02 & 0x7f);
            }
            *(u32 *)slot = handle;
        }
        return;
    }

    entity->status &= 0xdfff;
}

void TileSound_Update(u8 tile)
{
    SoundState *p;
    SoundState *slotBase;
    SoundState *stopBase;
    SoundState *stopSlotBase;
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
    p = (SoundState *)&gIwram_3570;
    slotBase = (SoundState *)((u8 *)p + 8);
    if (SoundHandle_IsActive(slotBase->entries[0].fieldB) != 0)
        return;

    sound = p->entries[1].fieldA;
    handle = -1;
    if ((p->flags & 0x10) != 0) {
        handle = Sound_AllocVoice(sound, 0xff, 0xff, 0xff);
        pan = 0x7f;
        p = (SoundState *)(u32)p->_field_02;
        pan &= (u32)p;
        SoundHandle_SetPan(handle, pan);
    }
    slotBase->entries[0].fieldB = handle;
    return;

startSlot0:
    p = (SoundState *)&gIwram_3570;
    if (SoundHandle_IsActive(p->entries[0].fieldB) != 0)
        return;

    sound = p->entries[0].fieldA;
    handle = -1;
    if ((p->flags & 0x10) != 0) {
        handle = Sound_AllocVoice(sound, 0xff, 0xff, 0xff);
        pan = 0x7f;
        pan &= p->_field_02;
        SoundHandle_SetPan(handle, pan);
    }
    p->entries[0].fieldB = handle;
    return;

stopSlots:
    stopBase = (SoundState *)&gIwram_3570;
    stopSlotBase = (SoundState *)((u8 *)stopBase + 8);
    SoundHandle_Retire(stopBase->entries[0].fieldB);
    SoundHandle_Retire(stopSlotBase->entries[0].fieldB);
    return;
}
