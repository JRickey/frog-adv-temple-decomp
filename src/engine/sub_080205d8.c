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

extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void sub_0802DC1C(u32 handle, u8 val);
extern u32 sub_0802E100(u32 handle);
extern u32 sub_0802E184(u32 handle);
extern u8 sub_08021E34(struct Entity *s, u8 halfW, u8 halfH);
extern void sub_08020414(struct Entity *entity, u8 channel, u8 halfW, u8 halfH);

void sub_080205D8(struct Entity *entity)
{
    StructAt3003570 *p;
    u32 sound;
    u32 handle;

    /* Case bodies are emitted in baserom physical order, which is not the
     * same as numeric case order (e.g. case 60 precedes case 59) — keeping
     * source order aligned to that layout is what holds the match. */
    switch (entity->field_00) {
    case 7:
        sub_08020414(entity, 2, 1, 2);
        return;

    case 8:
        sub_08020414(entity, 3, 1, 2);
        return;

    case 13:
        sub_08020414(entity, 4, 1, 2);
        return;

    case 83:
        sub_08020414(entity, 2, 1, 1);
        return;

    case 33:
        sub_08020414(entity, 2, 2, 2);
        return;

    case 38:
        if (sub_08021E34(entity, 1, 1) != 0) {
            p = (StructAt3003570 *)&gIwram_3570;
            if (sub_0802E184(p->entries[3].fieldB) != 0)
                return;

            sound = p->entries[3].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                sub_0802DC1C(handle, p->c & 0x7f);
            }
            p->entries[3].fieldB = handle;
        }
        return;

    case 48:
        sub_08020414(entity, 2, 1, 2);
        return;

    case 49:
        sub_08020414(entity, 3, 1, 1);
        return;

    case 57:
        sub_08020414(entity, 4, 1, 1);
        return;

    case 10:
    case 27:
    case 47:
        sub_08020414(entity, 5, 1, 2);
        return;

    case 55:
        if (sub_08021E34(entity, 1, 1) != 0) {
            p = (StructAt3003570 *)&gIwram_3570;
            if (sub_0802E184(p->entries[8].fieldB) != 0)
                return;

            sound = p->entries[8].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                sub_0802DC1C(handle, p->c & 0x7f);
            }
            p->entries[8].fieldB = handle;
            return;
        }
        sub_0802E100(((StructAt3003570 *)&gIwram_3570)->entries[8].fieldB);
        return;

    case 58:
        if (sub_08021E34(entity, 1, 1) != 0) {
            p = (StructAt3003570 *)&gIwram_3570;
            if (sub_0802E184(p->entries[2].fieldB) != 0)
                return;

            sound = p->entries[2].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                sub_0802DC1C(handle, p->c & 0x7f);
            }
            p->entries[2].fieldB = handle;
        }
        return;

    case 60:
        sub_08020414(entity, 3, 1, 1);
        return;

    case 59:
        if (sub_08021E34(entity, 1, 1) != 0) {
            p = (StructAt3003570 *)&gIwram_3570;
            if (sub_0802E184(p->entries[4].fieldB) != 0)
                return;

            sound = p->entries[4].fieldA;
            handle = -1;
            if ((p->flags & 0x10) != 0) {
                handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
                sub_0802DC1C(handle, p->c & 0x7f);
            }
            p->entries[4].fieldB = handle;
        }
        return;

    case 88:
        sub_08020414(entity, 4, 1, 1);
        return;

    case 92:
        sub_08020414(entity, 6, 1, 1);
        return;

    case 91:
        sub_08020414(entity, 7, 1, 1);
        return;
    }
}
