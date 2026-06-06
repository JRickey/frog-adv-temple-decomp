#include "types.h"

typedef struct {
    u16 a;
    s16 b;
    u16 c;
    s16 d;
} Entry;

extern u8 Entity_WaypointDirectionCompare(Entry *base, u8 idxA, u8 idxB);

u8 TileEntry_CalcDirection(Entry *a, Entry *b)
{
    Entry tmp[2];

    tmp[0].a = a->a;
    tmp[0].b = a->b;
    tmp[1].a = b->a;
    tmp[1].b = b->b;

    return Entity_WaypointDirectionCompare(tmp, 0, 1);
}
