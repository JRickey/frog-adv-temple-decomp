#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Multi-bit dispatch on gIwram_35E0._field_10. Tests eight bits in turn
 * via sub_08006BA4 and, for each set bit, applies a per-bit effect on the
 * 0x03006110 / gIwram_3720 state clusters before clearing the bit (and
 * usually bit 0x02) via sub_08006B94. The tail unconditionally clears
 * three more bits (0x20, 0x10, 0x40).
 *
 * Bit map (tested against gIwram_35E0._field_10):
 *   0x0100 -> OR 0x08 into *(u16 *)(0x03006110 + 0x2e); set bit 0x01;
 *             clear bits 0x100, 0x10.
 *   0x0080 -> gIwram_3720._field_1A += 0x24; gIwram_3720._field_34 |= 0x02;
 *             clear bit 0x80.
 *   0x0800 -> sub_0802090C(); set _field_1A = 22, _field_34 = 6.
 *   0x0400 -> sub_0802090C(); set _field_1A = 20, _field_34 = 22.
 *   0x0200 -> sub_0802090C(); set _field_1A = 20, _field_34 = 6.
 *   0x2000 -> sub_0802090C(); set _field_1A = 23, _field_34 = 54.
 *   0x4000 -> sub_0802090C(); set _field_1A = 33; _field_34 |= 2 | 4.
 *   0x8000 -> sub_0802090C(); set _field_1A = 34; _field_34 |= 2 | 4.
 *
 * Matching notes (agbcc 2.x):
 *   - `t = K; t |= load; store = t;` shape forces baserom's
 *     `movs #K; ldrh; orrs; strh` pattern instead of agbcc folding to
 *     `ldrh; orrs; strh`. Same trick as sub_080011A4 block 2.
 *   - `p35E0` is a struct pointer local so r4 stays anchored to
 *     gIwram_35E0 across every BL.
 */

extern void sub_0802090C(void);
extern void sub_08006B88(void *p, u16 mask);
extern void sub_08006B94(void *p, u16 mask);
extern u8 sub_08006BA4(void *p, u16 mask);
extern u32 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern u8 sub_0800803C(s16 x0, s16 y0, s16 x1, s16 y1);

struct ActorRecord {
    u8 _pad00[2];
    s16 _h2;
    s16 _h4;
    u8 _pad06[0x1e];
    s16 _h24;
    s16 _h26;
    u8 _pad28;
    u8 _b29;
    u8 _pad2a[0x0e];
};

void sub_08007DD0(void)
{
    struct IwramAt35E0 *p35E0 = &gIwram_35E0;
    u8 *base6110;

    if ((u8)sub_08006BA4(p35E0, 0x100) != 0) {
        u16 t;
        base6110 = (u8 *)0x03006110;
        t = 8;
        t |= *(u16 *)(base6110 + 0x2e);
        *(u16 *)(base6110 + 0x2e) = t;
        sub_08006B88(p35E0, 1);
        sub_08006B94(p35E0, 0x100);
        sub_08006B94(p35E0, 0x10);
    }

    if ((u8)sub_08006BA4(p35E0, 0x80) != 0) {
        u8 *base3720 = (u8 *)&gIwram_3720;
        u16 t;
        *(u8 *)(base3720 + 0x1A) += 0x24;
        t = 2;
        t |= *(u16 *)(base3720 + 0x34);
        *(u16 *)(base3720 + 0x34) = t;
        sub_08006B94(p35E0, 0x80);
    }

    if ((u8)sub_08006BA4(p35E0, 0x800) != 0) {
        sub_0802090C();
        gIwram_3720._field_1A = 22;
        gIwram_3720._field_34 = 6;
        sub_08006B94(p35E0, 0x800);
        sub_08006B94(p35E0, 2);
    }

    if ((u8)sub_08006BA4(p35E0, 0x400) != 0) {
        sub_0802090C();
        gIwram_3720._field_1A = 20;
        gIwram_3720._field_34 = 22;
        sub_08006B94(p35E0, 0x400);
        sub_08006B94(p35E0, 2);
    }

    if ((u8)sub_08006BA4(p35E0, 0x200) != 0) {
        sub_0802090C();
        gIwram_3720._field_1A = 20;
        gIwram_3720._field_34 = 6;
        sub_08006B94(p35E0, 0x200);
        sub_08006B94(p35E0, 2);
    }

    if ((u8)sub_08006BA4(p35E0, 0x2000) != 0) {
        sub_0802090C();
        gIwram_3720._field_1A = 23;
        gIwram_3720._field_34 = 54;
        sub_08006B94(p35E0, 0x2000);
        sub_08006B94(p35E0, 2);
    }

    if ((u8)sub_08006BA4(p35E0, 0x4000) != 0) {
        u16 t;
        sub_0802090C();
        gIwram_3720._field_1A = 33;
        t = 2;
        t |= gIwram_3720._field_34;
        t |= 4;
        gIwram_3720._field_34 = t;
        sub_08006B94(p35E0, 0x4000);
        sub_08006B94(p35E0, 2);
    }

    if ((u8)sub_08006BA4(p35E0, 0x8000) != 0) {
        u16 t;
        sub_0802090C();
        gIwram_3720._field_1A = 34;
        t = 2;
        t |= gIwram_3720._field_34;
        t |= 4;
        gIwram_3720._field_34 = t;
        sub_08006B94(p35E0, 0x8000);
        sub_08006B94(p35E0, 2);
    }

    sub_08006B94(p35E0, 0x20);
    sub_08006B94(p35E0, 0x10);
    sub_08006B94(p35E0, 0x40);
}

u8 sub_08007F88(void)
{
    struct IwramAt35E0 *p35E0 = &gIwram_35E0;
    u8 tileClass;

    tileClass = (u8)sub_0800CD88(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    if (p35E0->_field_1A == 0) {
        u16 flags = p35E0->_field_10;
        if ((flags & 2) == 0)
            goto tile_test;
    }
    {
        s16 x = gIwram_3720._field_2;
        s16 y = gIwram_3720._field_4;
        u8 entryIndex = p35E0->_field_D;
#define ACTOR_RECORD ((struct ActorRecord *)((u8 *)&gIwram_3720 + entryIndex * 56))
        if (sub_0800803C(x, y, (s16)(ACTOR_RECORD->_h2 + ACTOR_RECORD->_h24),
                         (s16)(ACTOR_RECORD->_h4 + ACTOR_RECORD->_h26 - (ACTOR_RECORD->_b29 >> 1))) != 0) {
            return 1;
        }
        return 0;
#undef ACTOR_RECORD
    }

tile_test:
    if ((u8)(tileClass - 7) <= 1 || tileClass == 11) {
        return 1;
    }

    if (sub_0800803C(gIwram_3720._field_2, gIwram_3720._field_4, p35E0->_field_8 * 24 + 11,
                     p35E0->_field_A * 24 + 11) != 0) {
        return 1;
    }

    return 0;
}
