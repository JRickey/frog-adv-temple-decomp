#include "types.h"

typedef struct {
    u16 a;
    u16 b;
    u16 c;
    u16 d;
} Entry;

u8 Entity_WaypointDirectionCompare(Entry *base, u8 idxA, u8 idxB)
{
    u8 result = 0;

    if (base[idxA].a == base[idxB].a) {
        if ((s16)base[idxA].b < (s16)base[idxB].b)
            result = 2;
        else if ((s16)base[idxA].b > (s16)base[idxB].b)
            result = 1;
    }

    if (base[idxA].b == base[idxB].b) {
        if ((s16)base[idxA].a < (s16)base[idxB].a)
            result = 4;
        else if ((s16)base[idxA].a > (s16)base[idxB].a)
            result = 3;
    }

    return result;
}
