#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_08006A74(struct IwramAt35E0 *p, s8 a, s16 b, s8 c, s8 e);
extern void sub_0800A710(struct IwramAt3720 *p, u8 a, s16 b, s16 c, u8 d, u16 e, u8 f, u8 g, u8 h, u16 i);

struct SpawnRec {
    s16 _h0;
    s16 _h2;
    u8 _b4;
    u8 _b5;
    u8 _b6;
    u8 _b7;
    u8 _b8;
};

/* gIwram_6110 +0x34 holds a base pointer into a table of SpawnRec arrays; the
 * state byte at +0x32 selects which array (one back), and `id` indexes into
 * the chosen array. The record's two leading halfwords become tile-to-pixel
 * positions (n*24 + 11) seeded into gIwram_35E0 / forwarded to sub_0800A710,
 * while sub_08006A74 re-reads the bytes just stored into gIwram_35E0. */

void sub_08007874(u8 id)
{
    struct SpawnRec *rec =
        (struct SpawnRec *)((const struct SpawnRec **)gIwram_6110._field_34)[gIwram_6110._field_32 - 1] + (s8)id;
    s16 px = rec->_h0 * 24 + 11;
    s16 py = rec->_h2 * 24 + 11;
    u8 b5;
    u8 b6;
    u8 b4;

    gIwram_35E0._field_8 = (u16)rec->_h0;
    gIwram_35E0._field_A = (u16)rec->_h2;
    b5 = rec->_b5;
    b6 = rec->_b6;
    b4 = rec->_b4;
    gIwram_35E0._field_18 = rec->_b7;
    gIwram_35E0._field_19 = rec->_b8;

    sub_08006A74(&gIwram_35E0, (s8)gIwram_35E0._data[0], *(s16 *)&gIwram_35E0._data[2], (s8)gIwram_35E0._data[4],
                 gIwram_35E0._field_5);

    sub_0800A710(&gIwram_3720, 0, px, py, b5, 1, 0, b6, b4, 16);
}
