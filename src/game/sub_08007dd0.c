#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Multi-bit dispatch on gIwram_35E0._field_10. Tests eight bits in turn
 * via IsFlagMaskSet and, for each set bit, applies a per-bit effect on the
 * 0x03006110 / gIwram_3720 state clusters before clearing the bit (and
 * usually bit 0x02) via IwramFlags_Clear. The tail unconditionally clears
 * three more bits (0x20, 0x10, 0x40).
 *
 * Bit map (tested against gIwram_35E0._field_10):
 *   0x0100 -> OR 0x08 into *(u16 *)(0x03006110 + 0x2e); set bit 0x01;
 *             clear bits 0x100, 0x10.
 *   0x0080 -> gEntities[0].field_1A += 0x24; gEntities[0].status |= 0x02;
 *             clear bit 0x80.
 *   0x0800 -> Entity_PlayStateSound(); set _field_1A = 22, _field_34 = 6.
 *   0x0400 -> Entity_PlayStateSound(); set _field_1A = 20, _field_34 = 22.
 *   0x0200 -> Entity_PlayStateSound(); set _field_1A = 20, _field_34 = 6.
 *   0x2000 -> Entity_PlayStateSound(); set _field_1A = 23, _field_34 = 54.
 *   0x4000 -> Entity_PlayStateSound(); set _field_1A = 33; _field_34 |= 2 | 4.
 *   0x8000 -> Entity_PlayStateSound(); set _field_1A = 34; _field_34 |= 2 | 4.
 *
 * Matching notes (agbcc 2.x):
 *   - `t = K; t |= load; store = t;` shape forces baserom's
 *     `movs #K; ldrh; orrs; strh` pattern instead of agbcc folding to
 *     `ldrh; orrs; strh`. Same trick as Entity_UpdateHudState block 2.
 *   - `p35E0` is a struct pointer local so r4 stays anchored to
 *     gIwram_35E0 across every BL.
 */

extern void Entity_PlayStateSound(void);
extern void IwramFlags_Clear(void *p, u16 mask);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s16 tileX, s16 tileY);
u8 Entity_MoveTowardTarget(s16 x, s16 y, s16 targetX, s16 targetY);

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

void Entity_ProcessEvents(void)
{
    struct IwramAt35E0 *p35E0 = &gIwram_35E0;
    u8 *base6110;

    if ((u8)IsFlagMaskSet(p35E0, 0x100) != 0) {
        u16 t;
        base6110 = (u8 *)0x03006110;
        t = 8;
        t |= *(u16 *)(base6110 + 0x2e);
        *(u16 *)(base6110 + 0x2e) = t;
        PlayerFlags_Set(p35E0, 1);
        IwramFlags_Clear(p35E0, 0x100);
        IwramFlags_Clear(p35E0, 0x10);
    }

    if ((u8)IsFlagMaskSet(p35E0, 0x80) != 0) {
        u8 *base3720 = (u8 *)gEntities;
        u16 t;
        *(u8 *)(base3720 + 0x1A) += 0x24;
        t = 2;
        t |= *(u16 *)(base3720 + 0x34);
        *(u16 *)(base3720 + 0x34) = t;
        IwramFlags_Clear(p35E0, 0x80);
    }

    if ((u8)IsFlagMaskSet(p35E0, 0x800) != 0) {
        Entity_PlayStateSound();
        gEntities[0].field_1A = 22;
        gEntities[0].status = 6;
        IwramFlags_Clear(p35E0, 0x800);
        IwramFlags_Clear(p35E0, 2);
    }

    if ((u8)IsFlagMaskSet(p35E0, 0x400) != 0) {
        Entity_PlayStateSound();
        gEntities[0].field_1A = 20;
        gEntities[0].status = 22;
        IwramFlags_Clear(p35E0, 0x400);
        IwramFlags_Clear(p35E0, 2);
    }

    if ((u8)IsFlagMaskSet(p35E0, 0x200) != 0) {
        Entity_PlayStateSound();
        gEntities[0].field_1A = 20;
        gEntities[0].status = 6;
        IwramFlags_Clear(p35E0, 0x200);
        IwramFlags_Clear(p35E0, 2);
    }

    if ((u8)IsFlagMaskSet(p35E0, 0x2000) != 0) {
        Entity_PlayStateSound();
        gEntities[0].field_1A = 23;
        gEntities[0].status = 54;
        IwramFlags_Clear(p35E0, 0x2000);
        IwramFlags_Clear(p35E0, 2);
    }

    if ((u8)IsFlagMaskSet(p35E0, 0x4000) != 0) {
        u16 t;
        Entity_PlayStateSound();
        gEntities[0].field_1A = 33;
        t = 2;
        t |= gEntities[0].status;
        t |= 4;
        gEntities[0].status = t;
        IwramFlags_Clear(p35E0, 0x4000);
        IwramFlags_Clear(p35E0, 2);
    }

    if ((u8)IsFlagMaskSet(p35E0, 0x8000) != 0) {
        u16 t;
        Entity_PlayStateSound();
        gEntities[0].field_1A = 34;
        t = 2;
        t |= gEntities[0].status;
        t |= 4;
        gEntities[0].status = t;
        IwramFlags_Clear(p35E0, 0x8000);
        IwramFlags_Clear(p35E0, 2);
    }

    IwramFlags_Clear(p35E0, 0x20);
    IwramFlags_Clear(p35E0, 0x10);
    IwramFlags_Clear(p35E0, 0x40);
}

u8 Entity_CheckAtTarget(void)
{
    struct IwramAt35E0 *p35E0 = &gIwram_35E0;
    u8 tileClass;

    tileClass = (u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    if (p35E0->_field_1A == 0) {
        u16 flags = p35E0->_field_10;
        if ((flags & 2) == 0)
            goto tile_test;
    }
    {
        s16 x = gEntities[0].x;
        s16 y = gEntities[0].y;
        u8 entryIndex = p35E0->_field_D;
#define ACTOR_RECORD ((struct ActorRecord *)((u8 *)gEntities + entryIndex * 56))
        if (Entity_MoveTowardTarget(x, y, (s16)(ACTOR_RECORD->_h2 + ACTOR_RECORD->_h24),
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

    if (Entity_MoveTowardTarget(gEntities[0].x, gEntities[0].y, p35E0->_field_8 * 24 + 11, p35E0->_field_A * 24 + 11) !=
        0) {
        return 1;
    }

    return 0;
}

/* Steps gEntities[0]'s (x,y) sub-coords toward the target (targetX, targetY),
 * at most 4 units per axis per call (clamped to the remaining distance: 1, 2,
 * 3, else 4). Returns 1 once both axes have reached the target this call, else
 * 0. Called from Entity_CheckAtTarget.
 *
 * The tail re-reads the stepped coords back into the x/y parameters (rather
 * than into fresh locals) on purpose: agbcc coalesces each re-read with the
 * incoming parameter, which gives x and y a 4th reference apiece. That extra
 * reference is what lifts their global-allocator priority above the
 * gEntities base pointer, so x/y win the low callee-saved registers (r4 for
 * y, r6 for x) ahead of the pointer (r5) - the baserom's allocation. Reading
 * the fields into separate locals leaves x/y at two references each, the
 * pointer outranks them, and the whole r4-r7 file rotates by one. */
u8 Entity_MoveTowardTarget(s16 x, s16 y, s16 targetX, s16 targetY)
{
    if (x > targetX) {
        switch ((s16)(x - targetX)) {
        case 1:
            gEntities[0].x -= 1;
            break;
        case 2:
            gEntities[0].x -= 2;
            break;
        case 3:
            gEntities[0].x -= 3;
            break;
        default:
            gEntities[0].x -= 4;
            break;
        }
    }
    if (x < targetX) {
        switch ((s16)(targetX - x)) {
        case 1:
            gEntities[0].x += 1;
            break;
        case 2:
            gEntities[0].x += 2;
            break;
        case 3:
            gEntities[0].x += 3;
            break;
        default:
            gEntities[0].x += 4;
            break;
        }
    }
    if (y > targetY) {
        switch ((s16)(y - targetY)) {
        case 1:
            gEntities[0].y -= 1;
            break;
        case 2:
            gEntities[0].y -= 2;
            break;
        case 3:
            gEntities[0].y -= 3;
            break;
        default:
            gEntities[0].y -= 4;
            break;
        }
    }
    if (y < targetY) {
        switch ((s16)(targetY - y)) {
        case 1:
            gEntities[0].y += 1;
            break;
        case 2:
            gEntities[0].y += 2;
            break;
        case 3:
            gEntities[0].y += 3;
            break;
        default:
            gEntities[0].y += 4;
            break;
        }
    }

    y = gEntities[0].y;
    x = gEntities[0].x;
    if (x != targetX) {
        return 0;
    }
    if (y == targetY) {
        return 1;
    }
    return 0;
}
