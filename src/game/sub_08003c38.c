#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Entity_RunScript(u32 id, void *obj);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene_UpdateCollisionAndTile(u32 arg0, u32 arg1, u32 arg2, u32 arg3, void *arg4, void *arg5);

void Mode12_SetupAndUpdate(void *arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, void *arg5, void *arg6)
{
    Entity_RunScript(1, arg0);
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Scene_UpdateCollisionAndTile(arg1, arg2, arg3, arg4, arg5, arg6);
    gGameStuff._unk14++;
}
