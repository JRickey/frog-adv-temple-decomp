#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Gate_HandleGateTile(u8 tile);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s16 tileX, s16 tileY);

/* Single-entity-pair variant of the Scene20_UpdateParts tile-cache probe (kind 17).
 * Enqueues the pair, maps the cached tile coords through Tilemap_GetTileClass, and —
 * when gIwram_35E0._field_10 has bit 0x10 set — re-enqueues with the resolved
 * tile and pokes Gate_HandleGateTile.
 *
 * Gated on IsFlagMaskSet(&gIwram_35E0, 0x40), a cascade of coordinate tests over
 * the cached tile X (gIwram_35E0._field_8) / Y (gIwram_35E0._field_A) stamps the
 * scenery class into gEntities[0].actorId and clears gIwram_35E0._field_1A. The
 * tail then fires IwramFlags_Clear for ten coord/x/y range gates.
 *
 * Matching notes (agbcc 2.x):
 *   - The first coord block reads through the r4-pinned p35E0 (the
 *     Tilemap_GetTileClass-surviving base); the remaining cascade blocks reference
 *     gIwram_35E0 directly so agbcc CSEs the base into one callee-saved
 *     register (r3) and re-reads each field fresh there. A `p35E0->` form for
 *     those blocks instead forces a per-block base reload + copy.
 *   - Each block caches its field read in a distinct local (one read, two
 *     compares); the packed-coord block reads *(u32 *)&p->_field_8 through a
 *     fresh pointer so the load reuses r3 with offset #8 instead of
 *     materialising base+8 as its own pool constant.
 *   - The tail references gIwram_35E0 / gEntities directly (no pointer locals)
 *     so the bases land in caller-saved registers and reload after each call
 *     rather than being kept across it in r4/r5. */

void Player_HandleTileTransitions(void *arg0, void *arg1)
{
    struct IwramAt35E0 *p35E0;
    struct IwramAt35E0 *p;
    u8 tile;
    int f8a, f8b, f8c, f8d, f8e;
    int fAa, fAb, fAc, fAd, fAe, fAf;
    u16 uf;
    u32 coord;

    Entity_UpdateHitboxWithTile((CollisionSlot *)arg0, (u64 *)arg1, 17);

    p35E0 = &gIwram_35E0;
    tile = (u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A);

    if ((0x10 & p35E0->_field_10) != 0) {
        Entity_ActivateHitSlot(arg0, arg1, 17, tile);
        Gate_HandleGateTile(tile);
    }

    if (!IsFlagMaskSet(p35E0, 0x40))
        goto tail;

    f8a = p35E0->_field_8;
    if (f8a == 13 || f8a == 6) {
        fAa = p35E0->_field_A;
        if (fAa == 23 || fAa == 21) {
            gEntities->actorId = 3;
            p35E0->_field_1A = 0;
        }
    }
    f8b = gIwram_35E0._field_8;
    if (f8b == 12 || f8b == 5) {
        fAb = gIwram_35E0._field_A;
        if (fAb == 23 || fAb == 21) {
            gEntities->actorId = 2;
            gIwram_35E0._field_1A = 0;
        }
    }
    f8c = gIwram_35E0._field_8;
    if (f8c == 8 || f8c == 2) {
        fAc = gIwram_35E0._field_A;
        if (fAc == 23 || fAc == 21) {
            gEntities->actorId = 3;
            gIwram_35E0._field_1A = 0;
        }
    }
    f8d = gIwram_35E0._field_8;
    if (f8d == 9 || f8d == 3) {
        fAd = gIwram_35E0._field_A;
        if (fAd == 23 || fAd == 21) {
            gEntities->actorId = 2;
            gIwram_35E0._field_1A = 0;
        }
    }
    fAe = gIwram_35E0._field_A;
    if (fAe == 3) {
        f8e = gIwram_35E0._field_8;
        if (f8e == 13 || f8e == 16 || f8e == 18 || f8e == 19 || f8e == 20) {
            gEntities->actorId = 2;
            gIwram_35E0._field_1A = 0;
        }
    }
    fAf = gIwram_35E0._field_A;
    if (fAf == 5) {
        uf = gIwram_35E0._field_8;
        if ((u16)(uf - 12) <= 4 || (s16)uf == 19 || (s16)uf == 20) {
            gEntities->actorId = 2;
            gIwram_35E0._field_1A = 0;
        }
    }
    if ((u16)((u16)gIwram_35E0._field_8 - 14) <= 1) {
        if (gIwram_35E0._field_A == 3) {
            gEntities->actorId = 3;
            gIwram_35E0._field_1A = 0;
        }
    }
    if ((u16)((u16)gIwram_35E0._field_8 - 17) <= 1) {
        if ((u16)gIwram_35E0._field_A == 5) {
            gEntities->actorId = 3;
            gIwram_35E0._field_1A = 0;
        }
    }
    if ((u16)((u16)gIwram_35E0._field_8 - 12) <= 9) {
        if ((u16)gIwram_35E0._field_A == 4) {
            gEntities->actorId = 3;
            gIwram_35E0._field_1A = 0;
        }
    }
    p = &gIwram_35E0;
    coord = *(u32 *)&p->_field_8;
    if (coord == 0x00010010 || coord == 0x0005000b || coord == 0x0007000e || coord == 0x0007000f) {
        gEntities->actorId = 3;
        gIwram_35E0._field_1A = 0;
    }

tail:
    if ((u16)gIwram_35E0._field_A == 23) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 216) <= 11)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)gIwram_35E0._field_A == 23) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 72) <= 11)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)gIwram_35E0._field_A == 21) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 131) <= 13)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)gIwram_35E0._field_A == 21) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 299) <= 13)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)gIwram_35E0._field_A == 3) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 328) <= 8)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)gIwram_35E0._field_A == 3) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 384) <= 5)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)gIwram_35E0._field_A == 5) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 402) <= 6)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)gIwram_35E0._field_A == 5) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].x - 456) <= 5)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
    if ((u16)((u16)gIwram_35E0._field_8 - 6) <= 4) {
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].y - 96) <= 11)
            IwramFlags_Clear(&gIwram_35E0, 2);
        if (gEntities[0].state <= 3 && (u16)(gEntities[0].y - 301) <= 35)
            IwramFlags_Clear(&gIwram_35E0, 2);
    }
}
