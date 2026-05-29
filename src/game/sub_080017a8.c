#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0800658C(void *p, u32 a, u32 b, const void *table, u32 e, u32 f);
extern void sub_0800CE98(u32 a, u32 b);
extern void sub_08009CBC(void);

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);

/* Mode-setup entry, sibling of sub_08001D18: installs config table
 * 0x082f9a1c into the gGameStuff_6110 cluster via the shared 6-arg
 * setup helper, then primes the post-setup state via
 * sub_0800CE98(5, 0) and sub_08009CBC(). */
void sub_080017A8(void)
{
    sub_0800658C((void *)0x03006110, 0x80, 5, (const void *)0x082f9a1c, 1, 3);
    sub_0800CE98(5, 0);
    sub_08009CBC();
}

/* Single-entity-pair (kind 4) variant of the sub_08004508 tile-cache probe,
 * preceded by the five per-frame setup calls and trailed by the
 * gGameStuff._unk14 frame counter bump. Enqueues the pair, then — gated on
 * gIwram_3720._field_34 & 4 — maps the cached tile coords through sub_0800CD88
 * and re-enqueues with the resolved tile when gIwram_35E0._field_10 & 0x10. */
void sub_080017DC(u32 arg0, u32 arg1)
{
    register u32 mask asm("r0");
    register struct IwramAt35E0 *p35E0 asm("r4");
    register u16 field asm("r4");
    struct IwramAt3720 *p3720;
    u8 tile;

    sub_0800A2D8();
    sub_080008DC();
    sub_0800A328();
    sub_080094F8();
    sub_08009984();

    sub_0800B918((void *)arg0, arg1, 4);

    p3720 = &gIwram_3720;
    mask = 4;
    mask &= p3720->_field_34;
    if (mask != 0)
        goto done;

    p35E0 = &gIwram_35E0;
    tile = (u8)sub_0800CD88(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    mask = 0x10;
    field = p35E0->_field_10;
    mask &= field;
    if (mask == 0)
        goto done;

    sub_0800B8A8((void *)arg0, arg1, 4, tile);

done:
    gGameStuff._unk14++;
}
