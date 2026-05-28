#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* AABB proximity test between the reference entity (gIwram_3720[0]) and
 * entity `idx` in the stride-0x38 entity array. Returns 1 when the
 * entity lies within a 0x104 (X) by 0xB4 (Y) half-window of the
 * reference, else 0. Called per-entity from sub_08009A58. */
u32 sub_0800D028(s32 idx)
{
    s32 refX;
    u8 *entity;
    s32 delta;

    refX = gIwram_3720._field_2;
    entity = (u8 *)&gIwram_3720 + idx * 0x38;

    delta = refX - *(s16 *)(entity + 2);
    if (delta < 0)
        delta = *(s16 *)(entity + 2) - refX;
    if (delta > 0x104)
        return 0;

    delta = gIwram_3720._field_4 - *(s16 *)(entity + 4);
    if (delta < 0)
        delta = *(s16 *)(entity + 4) - gIwram_3720._field_4;
    if (delta > 0xb4)
        return 0;

    return 1;
}
