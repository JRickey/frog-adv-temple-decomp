#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Three-entity-pair variant of the sub_08004508 tile-cache probe (kinds 6, 7
 * and 22 instead of 11 and 16). Enqueues all three pairs, then — gated on
 * gIwram_3720._field_34 & 4 — maps the cached tile coords through sub_0800CD88
 * and re-enqueues them with the resolved tile when gIwram_35E0._field_10 has
 * bit 0x10 set, also poking sub_0800C444.
 *
 * The tail does two coordinate-driven dispatches. The first, gated on
 * sub_08006BA4(&gIwram_35E0, 0x40), reads the packed tile coordinate
 * (*(u32 *)&gIwram_35E0._field_8) and stamps gIwram_3720._field_6 with a
 * scenery class (2 or 3) for a fixed set of coords. The second, gated on
 * gGameStuff._unk10 & 1 being clear, OR-bits 0x200 into gIwram_35E0 via
 * sub_08006B88 for another fixed coord set.
 *
 * Matching notes (agbcc 2.x): arg1/arg2/arg3 and the two stack args survive
 * across the enqueue calls in the high callee-saved registers the allocator
 * picks (r8/r9/sl); those need no explicit pins. The `mask asm("r0")` pin keeps
 * the AND-test constant in r0 (`movs #K; ldrh; ands`); `gs asm("r1")` anchors
 * the gGameStuff pointer load ahead of that constant. The first coord-compare
 * block reads the packed coordinate (adjacent s16 _field_8/_field_A as one u32)
 * once into r2, copies to r1 for six compares (`c asm("r1")` / `coord asm("r2")`)
 * and the seventh re-reaches r2 via `coord`; the k0 const-hoist orders the K1
 * pool load before that copy. The trailing block re-reads through `q asm("r4")`
 * each compare. */

extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern void sub_0800BF24(void *ent, void *arg1, u8 kind);
extern void sub_0800BEBC(void *ent, void *arg1, u8 kind, u8 tile);
extern void sub_0800C444(u8 tile);
extern u32 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern u8 sub_08006BA4(struct IwramAt35E0 *p, u32 mask);
extern void sub_08006B88(struct IwramAt35E0 *p, u32 mask);

void sub_08003668(u32 arg0, u32 arg1, u32 arg2, u32 arg3, void *arg4, void *arg5)
{
    struct IwramAt3720 *p3720;
    struct IwramAt35E0 *p35E0;
    register struct IwramAt35E0 *q asm("r4");
    register GameStuff *gs asm("r1");
    register u32 mask asm("r0");
    u8 tile;
    register u32 coord asm("r2");
    register u32 c asm("r1");
    u32 k0;

    sub_0800B918((void *)arg0, arg1, 6);
    sub_0800B918((void *)arg2, arg3, 7);
    sub_0800BF24(arg4, arg5, 22);

    p3720 = &gIwram_3720;
    mask = 4;
    mask &= p3720->_field_34;
    if (mask != 0)
        return;

    p35E0 = &gIwram_35E0;
    tile = (u8)sub_0800CD88(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    mask = 0x10;
    mask &= p35E0->_field_10;
    if (mask != 0) {
        sub_0800B8A8((void *)arg0, arg1, 6, tile);
        sub_0800B8A8((void *)arg2, arg3, 7, tile);
        sub_0800BEBC(arg4, arg5, 22, tile);
        sub_0800C444(tile);
    }

    if (sub_08006BA4(p35E0, 0x40)) {
        coord = *(u32 *)&p35E0->_field_8;
        /* Hoisting the first comparison constant into k0 before the copy makes
         * agbcc load it ahead of the `adds r1, r2` coord copy, matching the
         * baserom's `ldr k0; adds r1, r2; cmp r1` schedule. */
        k0 = 0x005e0002;
        c = coord;
        if (c == k0)
            p3720->_field_6 = 2;
        if (c == 0x00590000)
            p3720->_field_6 = 2;
        if (c == 0x00590001)
            p3720->_field_6 = 2;
        if (c == 0x005d0002)
            p3720->_field_6 = 3;
        if (c == 0x005e0003)
            p3720->_field_6 = 3;
        if (c == 0x005f0002)
            p3720->_field_6 = 3;
        if (coord == 0x00580002)
            p3720->_field_6 = 3;
    }

    gs = &gGameStuff;
    mask = 1;
    mask &= gs->_unk10;
    if (mask != 0)
        return;

    q = &gIwram_35E0;
    if (*(u32 *)&q->_field_8 == 0x001f0014)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x001f0016)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x001c0014)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x001c0015)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x00190015)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x00190016)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x00220014)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x00220015)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x00250015)
        sub_08006B88(q, 0x200);
    if (*(u32 *)&q->_field_8 == 0x00250016)
        sub_08006B88(q, 0x200);
}
