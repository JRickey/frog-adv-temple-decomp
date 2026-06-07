#include "game.h"
#include "iwram.h"
#include "types.h"

/* Fixed8Mul returns an 8.8 fixed-point s16; declared int here so the
 * caller trusts the already-sign-extended return register instead of
 * re-extending it before the s32 add below. */
extern int Fixed8Mul(s16 a, s16 b);
extern void Entity_Update(void *p);
extern const s16 sSineTable[320];

void Entity_UpdateOrbitalPosition(u8 idx, u16 baseX, u16 baseY, s8 mag, u8 mode, u8 delta)
{
    struct Entity *slot;
    s32 angle;
    s32 sx;
    s32 sy;

    if (mode == 1) {
        struct Entity *base = gEntities;
        struct Entity *e = base + idx;
        if (e->field_10 == 0xFF)
            e->field_10 = 0;
        e->field_10 += delta;
        if ((s16)e->field_10 > 0xFF)
            e->field_10 = 0xFF;
    } else if (mode == 0) {
        struct Entity *base = gEntities;
        struct Entity *e = base + idx;
        if ((s16)e->field_10 == 0)
            e->field_10 = 0xFF;
        e->field_10 -= delta;
        if ((s16)e->field_10 < 0)
            e->field_10 = 0;
    }

    {
        struct Entity *base = gEntities;
        slot = base + idx;
    }
    angle = slot->field_10;
    if ((s16)slot->field_10 - 0x40 < 0)
        angle = (u16)(angle + 0xFF);

    sx = (s16)baseX + Fixed8Mul(sSineTable[(s16)angle], mag);
    slot->x = sx;

    sy = (s16)baseY + Fixed8Mul(sSineTable[(s16)angle - 0x40], mag);
    slot->y = sy;

    if ((gIwram_35E0._field_10 & 2) != 0 && idx == gIwram_35E0.colliderTag) {
        gEntities[0].x = slot->x;
        gEntities[0].y = slot->y;
    }

    Entity_Update(&gEntities[idx]);
}
