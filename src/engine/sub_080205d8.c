#include "sound.h"
#include "types.h"
#include "iwram.h"

extern u8 gIwram_3570;

extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void SoundHandle_SetPan(u32 handle, u8 val);
extern u32 SoundHandle_Retire(u32 handle);
extern u32 SoundHandle_IsActive(u32 handle);
extern u8 Entity_IsInTileRange(struct Entity *s, u8 halfW, u8 halfH);
extern void Entity_ProximitySound(struct Entity *entity, u8 channel, u8 halfW, u8 halfH);

void Entity_DispatchSound(struct Entity *entity)
{
    SoundState *p;
    u32 sound;
    u32 handle;

    /* Case bodies are emitted in baserom physical order, which is not the
     * same as numeric case order (e.g. case 60 precedes case 59) — keeping
     * source order aligned to that layout is what holds the match. */
    switch (entity->kind) {
    case 7:
        Entity_ProximitySound(entity, 2, 1, 2);
        return;

    case 8:
        Entity_ProximitySound(entity, 3, 1, 2);
        return;

    case 13:
        Entity_ProximitySound(entity, 4, 1, 2);
        return;

    case 83:
        Entity_ProximitySound(entity, 2, 1, 1);
        return;

    case 33:
        Entity_ProximitySound(entity, 2, 2, 2);
        return;

    case 38:
        if (Entity_IsInTileRange(entity, 1, 1) != 0) {
            p = (SoundState *)&gIwram_3570;
            if (SoundHandle_IsActive(p->entries[3].fieldB) != 0)
                return;

            sound = p->entries[3].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                SoundHandle_SetPan(handle, p->_field_02 & 0x7f);
            }
            p->entries[3].fieldB = handle;
        }
        return;

    case 48:
        Entity_ProximitySound(entity, 2, 1, 2);
        return;

    case 49:
        Entity_ProximitySound(entity, 3, 1, 1);
        return;

    case 57:
        Entity_ProximitySound(entity, 4, 1, 1);
        return;

    case 10:
    case 27:
    case 47:
        Entity_ProximitySound(entity, 5, 1, 2);
        return;

    case 55:
        if (Entity_IsInTileRange(entity, 1, 1) != 0) {
            p = (SoundState *)&gIwram_3570;
            if (SoundHandle_IsActive(p->entries[8].fieldB) != 0)
                return;

            sound = p->entries[8].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                SoundHandle_SetPan(handle, p->_field_02 & 0x7f);
            }
            p->entries[8].fieldB = handle;
            return;
        }
        SoundHandle_Retire(((SoundState *)&gIwram_3570)->entries[8].fieldB);
        return;

    case 58:
        if (Entity_IsInTileRange(entity, 1, 1) != 0) {
            p = (SoundState *)&gIwram_3570;
            if (SoundHandle_IsActive(p->entries[2].fieldB) != 0)
                return;

            sound = p->entries[2].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                SoundHandle_SetPan(handle, p->_field_02 & 0x7f);
            }
            p->entries[2].fieldB = handle;
        }
        return;

    case 60:
        Entity_ProximitySound(entity, 3, 1, 1);
        return;

    case 59:
        if (Entity_IsInTileRange(entity, 1, 1) != 0) {
            p = (SoundState *)&gIwram_3570;
            if (SoundHandle_IsActive(p->entries[4].fieldB) != 0)
                return;

            sound = p->entries[4].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                SoundHandle_SetPan(handle, p->_field_02 & 0x7f);
            }
            p->entries[4].fieldB = handle;
        }
        return;

    case 88:
        Entity_ProximitySound(entity, 4, 1, 1);
        return;

    case 92:
        Entity_ProximitySound(entity, 6, 1, 1);
        return;

    case 91:
        Entity_ProximitySound(entity, 7, 1, 1);
        return;
    }
}
