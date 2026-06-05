#include "iwram.h"
#include "types.h"

u8 sub_08021E34(struct Entity *s, u8 halfW, u8 halfH)
{
    s16 tileX = (s16)((s16)s->x / 24);
    s16 tileY = (s16)((s16)s->y / 24);
    u16 dx;
    s16 dxSigned;
    u16 dy;

    if (gIwram_35E0._field_8 - tileX >= 0)
        dx = (u16)(gIwram_35E0._field_8 - tileX);
    else
        dx = (u16)(tileX - gIwram_35E0._field_8);
    dxSigned = (s16)dx;

    if (gIwram_35E0._field_A - tileY >= 0)
        dy = (u16)(gIwram_35E0._field_A - tileY);
    else
        dy = (u16)(tileY - gIwram_35E0._field_A);

    if (dxSigned > halfW)
        return 0;
    if ((s16)dy > halfH)
        return 0;
    return 1;
}
