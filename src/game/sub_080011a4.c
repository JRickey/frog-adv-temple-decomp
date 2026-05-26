#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Input/state gate that fans out into three independent subsystem pokes:
 *
 *   1. If gIwram_3720._field_34 & 4 is set, raise a single flag via
 *      sub_080066C4(0x03006110, 8, 1) and skip the rest of the function.
 *   2. Otherwise call the predicate sub_0800679C(0x03006110, 5, 15); when
 *      it returns nonzero, OR bit 8 into the halfword at 0x03006110[+0x2e].
 *   3. If gIwram_35E0._field_10 & 0x10 is set, sample the cached tile
 *      coords (gIwram_35E0._field_18/19/8/A), run sub_0800CD88 to map
 *      them to a tile id, and hand the (u8)tile to sub_0800AB84.
 *
 * Same gIwram_3720._field_34 & 4 gate appears in sub_08000B6C /
 * sub_08000E0C — this function looks like another per-entity probe in
 * the same family, with a lighter (single sub_0800CD88 / sub_0800AB84)
 * tail instead of the &0x10 dispatch + bit-test guard those siblings
 * use.
 *
 * Matching notes (agbcc 2.x):
 *   - `register u32 mask asm("r0")` pins the mask-test result to r0 so
 *     the two `mask = K; mask &= field` blocks emit
 *     `movs r0, #K; ldrh rN, [base, #o]; ands r0, rN` (the mask-first /
 *     base-overwrite shape — see docs/codegen-notes.md "Mask-before-
 *     field-load on a single-use struct base").
 *   - `register u16 field asm("r4")` on the second test (block 3) forces
 *     the field load into r4 (the just-freed second-pool base register)
 *     instead of r1 (which agbcc would otherwise pick).
 *   - The OR-and-write in block 2 is split into three statements
 *     (`t = 8; t |= load; store = t;`) to defeat the `ldrh ; orrs ; strh`
 *     fold and emit baserom's `movs #8 ; ldrh ; orrs ; strh` shape.
 *   - `base6110` as a local `u8 *` keeps r4 anchored to 0x03006110 across
 *     the BL to sub_0800679C so the post-call ldrh/strh reuse the same
 *     base register at +0x2e instead of materializing a fresh
 *     0x0300613e pool entry. */

extern void sub_080066C4(u32 base, u32 idx, u32 val);
extern u32 sub_0800679C(u32 base, u32 a, u32 b);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800AB84(u8 tile);

void sub_080011A4(void)
{
    register u32 mask asm("r0");
    register u16 field asm("r4");
    struct IwramAt3720 *p3720 = &gIwram_3720;
    struct IwramAt35E0 *p35E0;
    u8 *base6110;
    u8 tile;

    mask = 4;
    mask &= p3720->_field_34;
    if (mask != 0) {
        sub_080066C4(0x03006110, 8, 1);
        return;
    }

    base6110 = (u8 *)0x03006110;
    if ((u8)sub_0800679C((u32)base6110, 5, 15) != 0) {
        u16 t = 8;
        t |= *(u16 *)(base6110 + 0x2e);
        *(u16 *)(base6110 + 0x2e) = t;
    }

    p35E0 = &gIwram_35E0;
    mask = 0x10;
    field = p35E0->_field_10;
    mask &= field;
    if (mask == 0)
        return;

    tile = (u8)sub_0800CD88(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);
    sub_0800AB84(tile);
}
