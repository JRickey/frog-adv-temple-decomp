#include "macros.h"
#include "iwram.h"
#include "types.h"

/* --- SpawnGrid_UpdateSection: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern u8 RandRange(u8 range);
extern void Sound_Play(u32 sound);
extern void ModeControl_SetBit(struct IwramAt6110 *control, s32 slot);
extern void Entity_Update(struct Entity *e);
extern void EntityMover_Tick(u8 slot);
extern void Entity_Init(struct Entity *p, u8 a, u16 x, u16 y, u8 actorId, u16 e, u8 f, u8 g, u8 state, u16 initFlags);

struct SpawnGridEntry {
    s16 x;
    s16 y;
    u8 col;
    u8 dy;
    u8 mode;
    s8 delay;
    u8 flags;
    u8 _pad09[3];
};

struct SpawnGridSubtable {
    u32 count;
    const struct SpawnGridEntry *slice;
};

extern const struct SpawnGridSubtable sSpriteGridSubtable[8];

void SpawnGrid_UpdateSection(void)
{
    register u8 *base asm("r7");
    const struct SpawnGridEntry *slice;
    u32 tick;
    s8 i;
    struct Entity *e;

    base = (u8 *)0x03003720;
    slice = sSpriteGridSubtable[*(s8 *)(base + 0x6aa)].slice;

    if (*(u16 *)(base + 0x69a) == 0xff) {
        gIwram_6110.flags2--;
        *(u16 *)(base + 0x698) = 0;
        *(u16 *)(base + 0x69a) = 0;
        *(u32 *)(base + 0x6b0) = gGameStuff._unk00;
        if (gIwram_6110.gateByte == 2)
            *(s8 *)(base + 0x6aa) = RandRange(5) + 3;
        else if (gIwram_6110.gateByte == 1)
            *(s8 *)(base + 0x6aa) = RandRange(5) + 3;
        else
            *(s8 *)(base + 0x6aa) = RandRange(3);

        *(u32 *)(base + 0x6b0) = gGameStuff._unk00;
        *(u16 *)(base + 0x698) = 0;
        *(u16 *)(base + 0x69a) = 0;
        if (gIwram_6110.flags2 == 0)
            return;
    }

    tick = gGameStuff._unk00;

    for (i = 0; i <= 7; i++) {
        e = &gEntities[i + 2];

        if ((*(s16 *)0x03003dba >> i) & 1) {
            e->status |= 8;
            continue;
        }

        if ((*(s16 *)(base + 0x698) >> i) & 1)
            goto age;

        if (tick - *(u32 *)(base + 0x6b0) <= (u32)slice[i].delay) {
            e->status |= 8;
            continue;
        }

        Entity_Init(e, 0x51, slice[i].x, slice[i].y, 3, (i % 8) * 16 + 0x41, 1, 3, 2, 16);

        if (slice[i].flags & 1)
            Sound_Play(0x3d);

        if (gIwram_6110.gateByte == 0) {
            e->field_32 = slice[i].mode;
            e->field_31 = slice[i].dy;
        } else {
            e->field_31 = slice[i].dy - 1;
            e->field_32 = slice[i].mode;
        }
        e->field_30 = slice[i].col;

        *(u16 *)(base + 0x698) |= 1 << i;
        ModeControl_SetBit(&gIwram_6110, i + 2);
        Entity_Update(e);
        continue;

    age:
        if (e->status & 8)
            continue;
        if ((s16)e->y > 178) {
            *(u16 *)0x03003dba |= 1 << i;
            e->status |= 8;
            continue;
        }
        if (e->status & 0x8000)
            e->status = (e->status & 0x7fff) | 2;
        EntityMover_Tick((u8)(i + 2));
        Entity_Update(e);
    }
}
#else
NAKED void SpawnGrid_UpdateSection(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x2a63c, 0x2c0\n");
}
#endif /* NON_MATCHING */
