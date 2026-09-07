#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern s32 RandRange(u8 range);
extern const u32 sLevelLayout_31813C[32];

void sub_0802D3C0(void)
{
    u8 *base;
    u32 offset;
    u16 value;

    Entity_InitSlotFromRecord(2, sLevelLayout_31813C, 0x10, 0x59, 0x41, 1, 3, 2);
    base = (u8 *)gEntities;
    value = ((const u16 *)sLevelLayout_31813C)[4];
    offset = 0xAF2;
    *(u16 *)(base + offset) = value;
    value = ((const u16 *)sLevelLayout_31813C)[5] + 0x3A;
    offset = 0xAF4;
    *(u16 *)(base + offset) = value;
}

u32 sub_0802D40C(u8 a, u8 b)
{
    u32 sum;
    u32 idx;
    struct Entity *entity;
    s32 threshold;
    s32 y;

    sum = a;
    sum += b;
    idx = sum << 3;
    idx -= sum;
    idx <<= 3;
    idx += (u32)gEntities;
    entity = (struct Entity *)idx;
    threshold = (RandRange(6) + 5) * 3;
    threshold <<= 19;
    y = (u16)entity->y;
    y <<= 16;

    if (y >= threshold) {
        return 1;
    }
    return 0;
}
