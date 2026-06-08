#include "game.h"
#include "iwram.h"
#include "types.h"

extern void EntityPool_UpdateOwned(u32 a0);
extern void Gate_Tick(void);

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayout_31805C[8];

extern struct Entity gEntities_03003720[];

void EntityPool_UpdateOwner58(void)
{
    EntityPool_UpdateOwned(0x58);
}

void EntityPool_UpdateOwner5B(void)
{
    Gate_Tick();
    EntityPool_UpdateOwned(0x5B);
}

void Entity22_SpawnFromLayout(void)
{
    u8 *base;
    u32 off;

    Entity_InitSlotFromRecord(22, sLevelLayout_31805C, 0x10, 0x60, 0x245, 4, 3, 1);
    base = (u8 *)gEntities;
    off = 0x0b7a;
    base[off] = 3;
}

u8 EntityPool_AreAllCaptured(void)
{
    u8 count;
    struct Entity *e;
    u8 bitmask;
    u8 *p;
    s32 i;

    count = 0;
    p = (u8 *)gEntities;
    bitmask = 8;
    e = (struct Entity *)(p + 0x1c0);
    i = 13;
    do {
        if (e->status & bitmask)
            count = (u8)(count + 1);
        e++;
        i--;
    } while (i >= 0);

    if (count == 14)
        return 1;
    return 0;
}
