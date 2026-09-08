#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct CenterRect {
    u16 y;
    u16 x;
    u16 height;
    u16 width;
};

struct PackedRect {
    s16 x;
    s16 y;
    s16 height;
    s16 width;
};

struct CollisionEntry {
    struct CenterRect rect;
    u8 matchKey;
    u8 _pad09[0x11];
    u8 state;
    u8 _pad1B[9];
};

extern struct Entity gEntities_03003720[];
extern s32 Rect_PointInRect(void *ctx, struct PackedRect rect, s16 c, s16 d);

/* Inlined copy of the sub_080076a4.c helper: the inline expansion is what
 * produces the null checks, the halfword-masked struct packing in r4/r5 and the
 * loop-hoisted 0xFFFF0000 / 0x0000FFFF mask constants in sl/r9. */
static inline s32 Rect_PointInCenterRectEx(void *ctx, struct CenterRect *rect, s16 c, s16 d)
{
    struct PackedRect packed;
    struct CenterRect *r;
    u32 widthShift;

    if (ctx == NULL || rect == NULL)
        return 0;

    widthShift = rect->width << 16;
    packed.x = rect->x - (widthShift >> 17);
    r = rect;
    packed.y = r->y - (r->height >> 1) - 1;
    packed.height = r->height;
    packed.width = widthShift >> 16;

    return Rect_PointInRect(ctx, packed, c, d);
}

s32 CollisionTable_ScanForPlayer(struct CollisionEntry *table, s8 count)
{
    s32 hit;
    s8 i;
    struct CollisionEntry *entry;
    struct Entity *player;

    hit = 0;
    if ((gEntities_03003720[0].status & 4) != 0)
        return 0;

    for (i = 0; i < count; i++) {
        /* index-first integer sum: adds r6, <off>, <base> (codegen-notes "Operand order of a single adds") */
        entry = (struct CollisionEntry *)(i * sizeof(struct CollisionEntry) + (u32)table);
        if ((entry->state & 5) == 4) {
            player = gEntities_03003720;
            if (player->actorId == entry->matchKey) {
                if (Rect_PointInCenterRectEx(player, &entry->rect, 0, 0) != 0)
                    hit = 1;
            }
        }
    }

    return hit;
}
