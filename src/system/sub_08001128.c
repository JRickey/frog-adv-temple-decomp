#include "game.h"
#include "types.h"

/* Cluster of four small dispatcher helpers between Scene09_Run (mode-9
 * inner loop) and Entity_UpdateHudState (an input gate). The cluster is glue
 * between the mode-9 / mode-11 inner loops in Scene09_Run / Scene11_AttractModeMain
 * and the per-entity probe dispatcher in Scene09_UpdatePlayerTile. None of the four
 * functions are referenced from any already-decompiled C — they are
 * called by Scene10_Main (still asm) which sits immediately after this
 * cluster and looks like another mode dispatcher.
 *
 * Shape sketch (verified by baserom objdump):
 *   EntityProbe_SetMode2(a, b)         — sets gGameStuff.pendingMode = 2 and calls
 *                                Entity_UpdateHitboxSlots(a, b, 3).
 *   EntityProbe_ResetAndDispatch(a, b)         — tail of an init/reset chain (5 subsystem
 *                                resets) followed by Scene09_UpdatePlayerTile(a, b)
 *                                and gGameStuff._unk14++; matches the
 *                                Scene08_PlayFrameTick pattern exactly with
 *                                Scene08_UpdatePlayerEntity swapped for Scene09_UpdatePlayerTile
 *                                (and no UpdateColumnClipSpans config-load step).
 *   EntityProbe_FinishOrSetup(p, a, b)      — calls Scene_EntityTick(p); if it returns 0
 *                                writes 7 to *p, then unconditionally
 *                                Entity_UpdateHitboxSlots(a, b, 3).
 *   ModeControl_Cleanup(void)         — single-statement thunk to Game_FrameEnd.
 */

extern void Entity_UpdateHitboxSlots(void *sp_buf, void *r4_obj, u32 arg2);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene09_UpdatePlayerTile(void *ent, u32 arg1);
extern void Game_FrameEnd(void);

void EntityProbe_SetMode2(void *a, void *b)
{
    gGameStuff.pendingMode = 2;
    Entity_UpdateHitboxSlots(a, b, 3);
}

void EntityProbe_ResetAndDispatch(void *a, u32 b)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Scene09_UpdatePlayerTile(a, b);
    gGameStuff._unk14++;
}

void EntityProbe_FinishOrSetup(u8 *p, void *a, void *b)
{
    if (Scene_EntityTick(p) == 0)
        *p = 7;
    Entity_UpdateHitboxSlots(a, b, 3);
}

void ModeControl_Cleanup(void)
{
    Game_FrameEnd();
}
