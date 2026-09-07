#include "iwram.h"
#include "types.h"

typedef struct {
    u16 a;
    u16 b;
    u16 c;
    u16 d;
} Entry_080219BC;

extern void Entity_AdvanceWaypoint(u8 *src, int dstIdxArg, int selectorArg, int idxArg, int cmpValArg);

void Entity_FollowPath(const void *base, u8 idx)
{
    u8 *src;
    struct Entity *e;
    u8 recIdx;
    u8 dir;
    u8 count;
    u8 selector;
    u16 status;
    struct Entity *ents;
    struct Entity *tailEnts;

    src = (u8 *)base;
    selector = src[4];
    count = src[0];

    ents = gEntities;
    e = ents + idx;
    recIdx = e->field_33;
    dir = e->state;

    if (e->status & 2)
        goto tail;

    switch (dir) {
    case 1: {
        Entry_080219BC *rec = (Entry_080219BC *)(recIdx * 8 + (u32)src);
        if ((u16)e->x != rec->a)
            goto tail;
        if ((s16)e->y > (s16)rec->b)
            goto tail;
        Entity_AdvanceWaypoint(src, idx, selector, recIdx, count);
        goto tail;
    }
    case 2: {
        Entry_080219BC *rec = (Entry_080219BC *)(recIdx * 8 + (u32)src);
        if ((u16)e->x != rec->a)
            goto tail;
        if ((s16)e->y < (s16)rec->b)
            goto tail;
        Entity_AdvanceWaypoint(src, idx, selector, recIdx, count);
        goto tail;
    }
    case 3: {
        Entry_080219BC *rec = (Entry_080219BC *)(recIdx * 8 + (u32)src);
        if ((s16)e->x > (s16)rec->a)
            goto tail;
        if ((u16)e->y != rec->b)
            goto tail;
        Entity_AdvanceWaypoint(src, idx, selector, recIdx, count);
        goto tail;
    }
    case 4: {
        Entry_080219BC *rec = (Entry_080219BC *)(recIdx * 8 + (u32)src);
        if ((s16)e->x < (s16)rec->a)
            goto tail;
        if ((u16)e->y != rec->b)
            goto tail;
        Entity_AdvanceWaypoint(src, idx, selector, recIdx, count);
        break;
    }
    default:
        break;
    }

tail:
    tailEnts = gEntities;
    e = tailEnts + idx;
    status = e->status;
    if (status & 0x8000) {
        u16 t = 2;
        t |= status;
        do {
        } while (0);
        e->status = t & 0x7fff;
    }
}

extern u32 GetFrameTick(void);
/* Fixed16Mul returns an s16; declared int so the caller trusts the
 * already-sign-extended return register (same as Entity_UpdateOrbitalPosition). */
extern int Fixed16Mul(s16 a, s16 b);
extern void Entity_AdvanceAnimFrames(s32 first, s32 last);
extern const s16 sSineTable[320];

#define ORBIT_TICK_INTERVAL 29

/* Places every satellite entity in [first, last] (except the pivot) on a
 * ring around gEntities[pivot]: slots after the pivot orbit on the -sin
 * side, slots before it on the +sin side, each one step further out.
 * `mode` is unused (the baserom never reads r3). */
void sub_08021AC8(u8 first, u8 pivot, u8 last, u8 mode, u8 delta)
{
    struct Entity *base;
    struct Entity *p;
    struct Entity *e;
    u32 offset;
    /* Memory-homed on purpose (gcc 2.x never promotes a multi-word struct
     * local): a register copy would let the loop optimizer hoist the
     * (s16) re-extension out of the loops. */
    struct {
        u32 x;
        u32 y;
    } origin;
    u8 radius;
    u8 i;
    s32 angle;
    s16 mag;
    s32 sx;
    s32 sy;

    base = gEntities;
    offset = pivot * 56;
    p = (struct Entity *)(offset + (u32)base);
    origin.x = (u16)p->x;
    origin.y = (u16)p->y;

    if (GetFrameTick() - *(u32 *)(offset + ((u32)gEntities + 0x20)) <= ORBIT_TICK_INTERVAL)
        return;

    if (p->field_10 == 0xFF)
        p->field_10 = 0;
    p->field_10 += delta;
    if ((s16)p->field_10 > 0xFF)
        p->field_10 = 0xFF;

    /* Baserom quirk: the pivot's angle test is evaluated through gEntities[i]
     * before i is assigned; the result is dead, but agbcc keeps the load. */
    if ((s16)gEntities[i].field_10 - 0x40 < 0)
        angle = 0;

    radius = p->visibilityHeight >> 1;
    for (i = pivot; i <= last; i++) {
        if (i == pivot)
            continue;
        {
            struct Entity *b = gEntities;
            e = b + i;
        }
        radius += e->visibilityHeight >> 1;
        if (e->field_10 == 0xFF)
            e->field_10 = 0;
        e->field_10 += delta;
        if ((s16)e->field_10 > 0xFF)
            e->field_10 = 0xFF;

        angle = e->field_10;
        if ((s16)e->field_10 - 0x40 < 0)
            angle = (u16)(angle + 0xFF);
        mag = radius << 8;
        sx = (s16)origin.x - Fixed16Mul(sSineTable[(s16)angle], mag);
        e->x = sx;
        sy = (s16)origin.y - Fixed16Mul(sSineTable[(s16)angle - 0x40], mag);
        e->y = sy;

        if ((gIwram_35E0._field_10 & 2) != 0 && i == gIwram_35E0.colliderTag) {
            gEntities[0].x = e->x;
            gEntities[0].y = e->y;
        }
    }

    radius = gEntities[pivot].visibilityHeight >> 1;
    for (i = first; i < pivot; i++) {
        {
            struct Entity *b = gEntities;
            e = b + i;
        }
        radius += e->visibilityHeight >> 1;
        if (e->field_10 == 0xFF)
            e->field_10 = 0;
        e->field_10 += delta;
        if ((s16)e->field_10 > 0xFF)
            e->field_10 = 0xFF;

        angle = e->field_10;
        if ((s16)e->field_10 - 0x40 < 0)
            angle = (u16)(angle + 0xFF);
        mag = radius << 8;
        sx = (s16)origin.x + Fixed16Mul(sSineTable[(s16)angle], mag);
        e->x = sx;
        sy = (s16)origin.y + Fixed16Mul(sSineTable[(s16)angle - 0x40], mag);
        e->y = sy;

        if ((gIwram_35E0._field_10 & 2) != 0 && i == gIwram_35E0.colliderTag) {
            gEntities[0].x = e->x;
            gEntities[0].y = e->y;
        }
    }

    Entity_AdvanceAnimFrames(first, last);
}
