#include "types.h"

typedef struct {
    u16 a;
    s16 b;
    u16 c;
    s16 d;
} Entry;

extern u8 sub_080217D4(Entry *base, u8 idxA, u8 idxB);

u8 sub_08021EC0(Entry *a, Entry *b)
{
    Entry tmp[2];

    tmp[0].a = a->a;
    tmp[0].b = a->b;
    tmp[1].a = b->a;
    tmp[1].b = b->b;

    return sub_080217D4(tmp, 0, 1);
}
