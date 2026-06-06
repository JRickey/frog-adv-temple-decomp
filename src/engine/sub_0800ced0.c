#include "macros.h"
#include "types.h"

/* --- Rect_PointInRect: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct Rect2 {
    u16 _field_0;
    s16 _field_2;
    s16 _field_4;
};

/* old_agbcc TU (sister grid functions all build under old_agbcc). */
u32 Rect_PointInRect(struct Rect2 *s, s32 a, s32 b, s16 c, s16 e)
{
    register s32 himask asm("r8");
    register s32 ee asm("r9"); /* s32 (not s16) — s16 adds a spurious (u16) ext */
    s32 va;
    s32 vb;
    s16 x0, y0, w, h;
    s16 rx, ry;
    u32 result;

    ee = e;
    va = (u16)(a - ee);
    himask = 0xffff0000;
    va = (a & himask) | va;
    if ((s16)va < 0)
        va = (va & himask);
    va = (va & 0x0000ffff) | (((s16)(va >> 16) - c) << 16);
    if ((s16)(va >> 16) < 0)
        va = (va & 0x0000ffff);

    vb = (b & himask) | (u16)(b + 2 * c);
    vb = (vb & 0x0000ffff) | (((s16)(vb >> 16) + 2 * ee) << 16);

    x0 = (s16)(va >> 16);
    y0 = (s16)va;
    w = (s16)vb;
    h = (s16)(vb >> 16);

    rx = s->_field_2;
    ry = s->_field_4;

    result = 0;
    if (rx < x0)
        return result;
    if (rx > x0 + w)
        return result;
    if (ry < y0)
        return result;
    if (ry > y0 + h)
        return result;
    result = 1;
    return result;
}
#else
NAKED void Rect_PointInRect(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0xced0, 0x10c\n");
}
#endif /* NON_MATCHING */
