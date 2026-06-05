#include "game.h"
#include "iwram.h"
#include "types.h"

/* sub_0800DFFC returns an 8.8 fixed-point s16; declared int here so the
 * caller trusts the already-sign-extended return register instead of
 * re-extending it before the s32 add below. */
extern int sub_0800DFFC(s16 a, s16 b);
extern void sub_080059C4(void *p);
extern const s16 sSineTable[320];

void sub_08021CFC(u8 idx, u16 baseX, u16 baseY, s8 mag, u8 mode, u8 delta)
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

    sx = (s16)baseX + sub_0800DFFC(sSineTable[(s16)angle], mag);
    slot->x = sx;

    sy = (s16)baseY + sub_0800DFFC(sSineTable[(s16)angle - 0x40], mag);
    slot->y = sy;

    if ((gIwram_35E0._field_10 & 2) != 0 && idx == gIwram_35E0._field_D) {
        gEntities[0].x = slot->x;
        gEntities[0].y = slot->y;
    }

    sub_080059C4(&gEntities[idx]);
}
