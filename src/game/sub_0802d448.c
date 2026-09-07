#include "game.h"
#include "iwram.h"
#include "types.h"

extern u8 gIwram_3610[];

u32 sub_0802D448(void)
{
    u8 count;
    u32 mask;
    s32 i;
    struct Entity *entity;
    struct Entity *base;

    count = 0;
    base = gEntities;
    mask = 8;
    entity = base + 3;
    i = 19;
    do {
        if ((entity->status & mask) != 0) {
            count++;
        }
        entity++;
        i--;
    } while (i >= 0);

    if (count == 20) {
        return 1;
    }
    return 0;
}

u32 sub_0802D484(void *unused, const s16 *pos)
{
    if (gIwram_3610[pos[1] * 14 + pos[0]] == 0) {
        return 1;
    }
    return 0;
}
