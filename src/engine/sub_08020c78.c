#include "types.h"
#include "sound.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern u8 gIwram_3570;
extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void SoundHandle_SetPan(u32 handle, u8 val);

u32 Sound_Play(u32 sound)
{
    StructAt3003570 *p;
    int mask;
    u32 handle;

    handle = -1;
    p = &gStructAt3003570;
    mask = 0x10;
    mask = mask & p->flags;
    if (mask != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
    }
    return handle;
}

u32 Sound_PlayWithPan(u32 sound)
{
    u32 snd;
    u32 handle;
    u32 pan;
    u32 result;
    StructAt3003570 *p;

    snd = sound;
    result = -1;
    p = (StructAt3003570 *)&gIwram_3570;
    handle = 0x10;
    handle = handle & p->flags;
    if (handle != 0) {
        handle = sub_0802D9EC(snd, 0xff, 0xff, 0xff);
        result = handle;
        pan = 0x7f;

        /* The pan byte read is the last use of `p`, so overwrite `p`'s own
         * register with the loaded byte (ldrb r5, [r5, #2]) instead of
         * spilling a fresh scratch — agbcc only reuses the dying base when
         * the load destination IS the pointer var. `p` must stay UNPINNED
         * for the allocator to colour it r5; pinning it forces ldrb r2. */
        p = (StructAt3003570 *)(u32)p->c;
        pan &= (u32)p;
        SoundHandle_SetPan(handle, pan);
    }
    return result;
}

#include "iwram.h"

extern u8 Entity_IsInTileRange(struct Entity *s, u8 halfW, u8 halfH);

u32 Sound_PlayNearEntity(struct Entity *entity, u32 sound, u8 halfW, u8 halfH)
{
    u32 result;
    u32 handle;
    u32 pan;
    register u32 r asm("r0");
    StructAt3003570 *p;

    r = Entity_IsInTileRange(entity, halfW, halfH);
    r <<= 24;
    if (!r)
        return r;

    result = -1;
    p = &gStructAt3003570;
    handle = 0x10;
    handle = handle & p->flags;
    if (handle) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
        result = handle;
        pan = 0x7f;
        p = (StructAt3003570 *)(u32)p->c;
        pan &= (u32)p;
        SoundHandle_SetPan(handle, pan);
    }
    return result;
}

u32 Entity_PlaySoundOnScreenEnter(struct Entity *entity, u32 sound, u8 halfW, u8 halfH)
{
    u32 r;
    u32 result;
    register u32 bit asm("r2");
    register u32 f34 asm("r1");
    u32 handle;
    u32 pan;
    StructAt3003570 *p;

    r = Entity_IsInTileRange(entity, halfW, halfH);
    r <<= 24;
    if (r) {
        f34 = entity->status;
        bit = 0x80;
        bit <<= 6;
        r = bit;
        r &= f34;
        if (r)
            return r;

        r = bit;
        r = r | f34;
        entity->status = r;
        result = -1;
        p = &gStructAt3003570;
        handle = 0x10;
        handle = handle & p->flags;
        if (handle) {
            handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
            result = handle;
            pan = 0x7f;
            p = (StructAt3003570 *)(u32)p->c;
            pan &= (u32)p;
            SoundHandle_SetPan(handle, pan);
        }
        return result;
    }
    r = 0x0000dfff;
    f34 = entity->status;
    r &= f34;
    entity->status = r;
    return r;
}

void Sound_ReplaySlotEntry(u8 index)
{
    StructAt3003570 *p;
    u32 offset;
    u32 *slot;
    u32 handle;

    p = (StructAt3003570 *)&gIwram_3570;
    offset = index * 8;
    slot = (u32 *)((u8 *)p + 4);
    slot = (u32 *)(offset + (u32)slot);
    handle = Sound_Play(*slot);
    p = (StructAt3003570 *)((u8 *)p + 8);
    offset = (u32)((u8 *)p + offset);
    *(u32 *)offset = handle;
}
