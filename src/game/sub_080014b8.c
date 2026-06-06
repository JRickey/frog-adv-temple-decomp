#include "game.h"
#include "types.h"

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Entity_UpdateHudState(void);
extern void Game_FrameEnd(void);
extern u32 Scene_EntityTick(u8 *state);

/* Per-frame gameplay tick: runs the entity-dispatch / render pipeline once
 * and bumps the frame counter. Same 6-call sequence + counter bump as the
 * case-3 active block of the mode_15 family (Scene15_Main etc.). */
void Scene10_FrameUpdate(void)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Entity_UpdateHudState();
    gGameStuff._unk14++;
}

/* Thin forwarder to Game_FrameEnd — same shape as Scene06_Exit
 * (push lr; bl Game_FrameEnd; pop r0; bx r0). */
void sub_080014E4(void)
{
    Game_FrameEnd();
}

/* On Scene_EntityTick reject: force state byte to 8. Same Scene_EntityTick guard
 * pattern as Scene_UpdateAnimState (state=7) and Scene_InitHitboxes (state=7). */
void sub_080014F0(u8 *state)
{
    if (Scene_EntityTick(state) == 0)
        *state = 8;
}
