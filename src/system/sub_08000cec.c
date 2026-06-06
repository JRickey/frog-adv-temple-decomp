#include "game.h"
#include "types.h"

/* Mode-init dispatcher: sequences a fixed set of subsystem resets, hands
 * off to Scene08_UpdatePlayerEntity with the caller's two args, then bumps a frame/tick
 * counter at gGameStuff offset 0x14. The first three callees take no args
 * (subsystem teardown), the fourth is a config loader (ROM table
 * 0x08306944, count 5), the last two are continued teardown. */

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void UpdateColumnClipSpans(u32 src, u32 count);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene08_UpdatePlayerEntity(u32 a, u32 b);

void Scene08_PlayFrameTick(u32 a, u32 b)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    UpdateColumnClipSpans(0x08306944, 5);
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Scene08_UpdatePlayerEntity(a, b);
    gGameStuff._unk14++;
}
