#include "macros.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

/* --- Enemy_PickNextStep: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

typedef struct {
    u16 a;
    s16 b;
    u16 c;
    s16 d;
} Entry;

#define GRID ((u8 *)0x03003610)

u8 Enemy_PickNextStep(Entry *e, s16 *out)
{
    struct Entity *p2;
    struct Entity *p0;
    s32 dx;
    s32 dy;
    u32 adx;
    u32 ady;
    u8 col;
    u8 row;
    s32 sc;
    s32 sr;
    s32 cur;
    s32 nr;
    register u8 *grid asm("r6"); /* keep grid in r6, reloaded per-leaf (8 loads) */

    p2 = &gEntities[2];
    p0 = (struct Entity *)((u8 *)p2 - 0x70); /* &gEntities[0] = literal - 0x70 */
    dx = (u16)p0->x - (u16)p2->x;
    dy = (u16)((u16)p0->y - (u16)p2->y); /* (u16) mask fixes sign-ext order */
    dx = (s16)dx;
    adx = (u8)((dx < 0) ? -dx : dx);
    dy = (s16)dy;
    ady = (u8)((dy < 0) ? -dy : dy);

    col = (u8)e->a;
    row = (u8)e->b;

    if (adx < ady) {
        /* vertical axis dominant */
        if (dy < 0) {
            grid = GRID;
            sr = (s8)row;
            sc = (s8)col;
            if (dx < 0) {
                /* [A] */
                nr = sr - 1;
                if (grid[nr * 14 + sc] != 0)
                    goto step_up;
                cur = sr * 14 + sc;
                if (grid[cur - 1] != 0)
                    goto step_left;
                nr = sr + 1;
                if (grid[nr * 14 + sc] != 0)
                    goto step_down;
                if (grid[cur + 1] != 0)
                    goto step_right;
                return 0;
            }
            /* [B] */
            nr = sr - 1;
            if (grid[nr * 14 + sc] != 0)
                goto step_up;
            cur = sr * 14 + sc;
            if (grid[cur + 1] != 0)
                goto step_right;
            if (grid[cur - 1] != 0)
                goto step_left;
            goto probe_down;
        }
        if (dy <= 0)
            return 0;
        grid = GRID;
        sr = (s8)row;
        sc = (s8)col;
        if (dx < 0) {
            /* [C] */
            nr = sr + 1;
            if (grid[nr * 14 + sc] != 0)
                goto step_down;
            cur = sr * 14 + sc;
            if (grid[cur - 1] != 0)
                goto step_left;
            if (grid[cur + 1] != 0)
                goto step_right;
            goto probe_up;
        }
        /* [D] */
        nr = sr + 1;
        if (grid[nr * 14 + sc] != 0)
            goto step_down;
        cur = sr * 14 + sc;
        if (grid[cur + 1] != 0)
            goto step_right;
        if (grid[cur - 1] != 0)
            goto step_left;
        goto probe_up;
    }

    /* horizontal axis dominant */
    if (dy < 0) {
        grid = GRID;
        sr = (s8)row;
        sc = (s8)col;
        cur = sr * 14 + sc;
        if (dx < 0) {
            /* [E] */
            if (grid[cur - 1] != 0)
                goto step_left;
            nr = sr - 1;
            if (grid[nr * 14 + sc] != 0)
                goto step_up;
            if (grid[cur + 1] != 0)
                goto step_right;
            goto probe_down;
        }
        /* [F] */
        if (grid[cur + 1] != 0)
            goto step_right;
        nr = sr - 1;
        if (grid[nr * 14 + sc] != 0)
            goto step_up;
        if (grid[cur - 1] != 0)
            goto step_left;
        goto probe_down;
    }
    if (dy <= 0)
        return 0;
    grid = GRID;
    sr = (s8)row;
    sc = (s8)col;
    cur = sr * 14 + sc;
    if (dx < 0) {
        /* [G] */
        if (grid[cur - 1] != 0)
            goto step_left;
        nr = sr + 1;
        if (grid[nr * 14 + sc] != 0)
            goto step_down;
        if (grid[cur + 1] != 0)
            goto step_right;
        goto probe_up;
    }
    /* [H] */
    if (grid[cur + 1] != 0)
        goto step_right;
    nr = sr + 1;
    if (grid[nr * 14 + sc] != 0)
        goto step_down;
    if (grid[cur - 1] != 0)
        goto step_left;
    goto probe_up;

probe_down:
    nr = sr + 1;
    if (grid[nr * 14 + sc] == 0)
        return 0;
step_down:
    out[0] = sc;
    out[1] = sr + 1;
    return 1;

step_left:
    out[0] = sc - 1;
    out[1] = sr;
    return 1;

step_right:
    out[0] = sc + 1;
    out[1] = sr;
    return 1;

probe_up:
    nr = sr - 1;
    if (grid[nr * 14 + sc] == 0)
        return 0;
step_up:
    out[0] = sc;
    out[1] = sr - 1;
    return 1;
}
#else
NAKED void Enemy_PickNextStep(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x2cafc, 0x2d4\n");
}
#endif /* NON_MATCHING */
