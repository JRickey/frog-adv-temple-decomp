#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Two-entity variant of the sub_080011A4 / sub_080018F8 tile-cache probe:
 * enqueues both entity pairs (kind 11 and 16), then — gated on the shared
 * gIwram_3720._field_34 & 4 counter — maps the cached tile coords through
 * sub_0800CD88 and, when gIwram_35E0._field_10 & 0x10 is set, re-enqueues
 * both pairs with the resolved tile and pokes sub_0800A9D4.
 *
 * Matching notes (agbcc 2.x):
 *   - `register u32 mask asm("r0")` pins both mask-AND tests to r0 so the
 *     `movs #K; ldrh; ands` shape emits with K in r0.
 *   - `register struct IwramAt35E0 *p35E0 asm("r4")` keeps the 0x030035e0
 *     base in r4 across the sub_0800CD88 call so the post-call
 *     `ldrh r4, [r4, #16]` reuses the same base register instead of
 *     reloading the pool literal. */

extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800A9D4(u8 tile);

void sub_08004508(u32 arg0, u32 arg1, u32 arg2, u32 arg3)
{
    register u32 mask asm("r0");
    register struct IwramAt35E0 *p35E0 asm("r4");
    register u16 field asm("r4");
    struct IwramAt3720 *p3720;
    u8 tile;

    sub_0800B918((void *)arg0, arg1, 11);
    sub_0800B918((void *)arg2, arg3, 16);

    p3720 = &gIwram_3720;
    mask = 4;
    mask &= p3720->_field_34;
    if (mask != 0)
        return;

    p35E0 = &gIwram_35E0;
    tile = (u8)sub_0800CD88(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    mask = 0x10;
    field = p35E0->_field_10;
    mask &= field;
    if (mask == 0)
        return;

    sub_0800B8A8((void *)arg0, arg1, 11, tile);
    sub_0800B8A8((void *)arg2, arg3, 16, tile);
    sub_0800A9D4(tile);
}
