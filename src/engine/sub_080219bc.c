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
