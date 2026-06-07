#include "game.h"
#include "gba/io.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const u8 sEntitySubtypeLut[];

/* Player_NormalizeStatusAndUpdate is declared void(void) in its own TU but the calling
 * convention here passes gEntities[0].x and .y as arguments — the callee
 * ignores r0/r1 (it reloads from pool immediately) but agbcc at the call
 * site still emits the ldrsh r0 / ldrsh r1 sequence. */
extern void Player_NormalizeStatusAndUpdate(s16 x, s16 y);
extern void BgScrollBlit(u8 arg);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void Game_ForceRender(void);

extern u8 gIwram_5330;

void Entity_UpdateAndRender(void)
{
    const GameProc *procs;
    GameStuff *base;
    u8 idx;
    u32 offset;

    Player_NormalizeStatusAndUpdate(gEntities[0].x, gEntities[0].y);

    ScrollCamera_Update(sEntitySubtypeLut[0]);
    BgScrollBlit(2);

    procs = sEntityProcB;
    base = (GameStuff *)&gIwram_5330;
    idx = base->pendingMode;
    offset = ((u32)idx << 2) + (u32)procs;
    ((GameProc)(*(const u32 *)offset))();

    Entity_UpdateVisibility();
    Entity_Advance();
    Game_ForceRender();
}

void Scene_StartTransition(u32 arg)
{
    /* r4 holds zero across four strh and one strb — prevents agbcc from
     * reloading a literal zero for each store. */
    register u32 zero asm("r4");
    vu16 *win;
    vu16 *dispcnt;
    u16 ctrl;
    u8 mode_val;

    mode_val = (u8)arg;

    win = (vu16 *)0x04000040;
    zero = 0;
    *win = zero;
    win += 2;
    *win = zero;
    win += 2;
    *win = zero;
    win += 1;
    *win = zero;

    /* 0x04000000 computed as 128<<19 keeps it out of the pool and produces the
     * baserom's movs r1, #128 / lsls r1, r1, #19 sequence. */
    dispcnt = (vu16 *)((u32)128 << 19);
    ctrl = *dispcnt;
    ctrl &= ~DISPCNT_WIN0_ON;
    *dispcnt = ctrl;
    ctrl = *dispcnt;
    ctrl &= ~DISPCNT_WIN1_ON;
    *dispcnt = ctrl;

    if (mode_val == 0)
        mode_val = 1;

    *(u8 *)0x03003540 = (u8)zero;
    gGameStuff.mode = mode_val + 7;
}
