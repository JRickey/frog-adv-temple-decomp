#include "game.h"
#include "types.h"

/* Sole caller of sEntityProcE — dispatches the per-entity-type "E" handler
 * (cleanup callback) by gGameStuff.pendingMode. See src/data/entity_dispatch.c
 * for the table layout (5 parallel 17-entry function-pointer tables).
 *
 * The indirect call lowers to `bl _call_via_r0` (libgcc thunk at 0x08033cd8)
 * — agbcc's standard Thumb function-pointer call sequence. */

typedef void (*GameProc)(void);

extern const GameProc sEntityProcE[17];

void EntityProcE_Dispatch(void)
{
    sEntityProcE[gGameStuff.pendingMode]();
}

extern void EntityPool_Reset(void);
extern void BgLayer_InitAndCommit(void);

void EntityProcE_Init(void)
{
    EntityPool_Reset();
    BgLayer_InitAndCommit();
}

extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern int BgScroll_Step(void);
extern u8 RunFadeTransition(s8 *phase, u32 callbackTable);

void EntityProcE_Run(void)
{
    u8 done = 0;
    s8 state = done;

    while (RunFadeTransition(&state, 0x0800DF9D) == 0) {
        WaitVblank();
    }

    while (!(done & 1)) {
        WaitVblank();
        if (BgScroll_Step() != 0)
            done |= 1;
        Entity_UpdateVisibility();
        Entity_Advance();
        Game_ForceRender();
    }
}
