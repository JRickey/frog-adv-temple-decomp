#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct Rect2 {
    u16 _field_0;
    s16 _field_2;
    s16 _field_4;
};

/* Rectangle containment test: returns 1 if (s->_field_2, s->_field_4) lies
 * strictly inside the rect [x, x+w) x [y, y+h).
 *
 * Match notes: old_agbcc required. The do-while(0) around the first pair of
 * checks + cached-y assignment causes agbcc to emit `adds r1, r0, #0` (save
 * field_2 to r1) instead of reloading; without it agbcc chooses a memory
 * reload and the size grows by 4 bytes. */
u32 Rect2_ContainsPoint(struct Rect2 *s, s16 x, s16 y, s16 w, s16 h)
{
    s16 y_cached;
    s16 f4;
    s16 y_s;

    do {
        if (s->_field_2 <= x)
            return 0;
        if (s->_field_2 >= x + w)
            return 0;
        y_cached = y;
        f4 = s->_field_4;
    } while (0);
    y_s = y_cached;
    if (s->_field_4 <= y_s)
        return 0;
    if (f4 >= y_s + h)
        return 0;
    return 1;
}
