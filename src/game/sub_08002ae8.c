#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void AnimTile_ResetAndClearBg(void);
extern void Entity_SpawnFromRecord(s8 id);
extern u8 RunFadeTransition(u8 *state, u32 callbackTable);

/* Mode entry that seeds the entity-dispatch state, ticks the per-frame
 * entity loop until its active-entity count (gEntities[0].field_1B) falls
 * to <= 4, then runs a one-shot spawn + waits on the RunFadeTransition gesture
 * gate (the 0x0800A26D callback table, same one the other mode handlers
 * pass for their final-confirmation step). */
void Scene_EnterLevel(void)
{
    /* Pin the base to r1 (agbcc otherwise colours r2, which propagates into
     * every dependent load/store and the r4 loop-anchor copy). */
    register struct Entity *p asm("r1") = gEntities;
    u8 state;
    u16 flags;

    p->field_1A = 21;
    /* split into three statements so agbcc emits movs/ldrh/orrs/strh
     * instead of folding to ldrh/orrs/strh */
    flags = 2;
    flags |= p->status;
    p->status = flags;

    if (gEntities[0].field_1B <= 4) {
        register u32 count asm("r2");
        do {
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
            count = gEntities[0].field_1B;
        } while (count <= 4);
    }

    state = 0;
    AnimTile_ResetAndClearBg();
    Entity_SpawnFromRecord((s8)(gIwram_6110.spawnMask + 1));

    while (RunFadeTransition(&state, 0x0800A26D) == 0) {
        WaitVblank();
    }
}
