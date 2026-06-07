#include "game.h"
#include "types.h"

extern void Entity_RunScript(u32 a, u32 b);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);

/* Per-frame tick for one of the mode handlers: drives shared input
 * (Entity_RunScript), per-frame state services (Game_RunEntityFrame / WaitVblank /
 * Game_ForceRender), the sprite/asset pump (Entity_CheckAllCollisions / Player_CheckTileEvents), then
 * defers mode-specific work to Scene12_UpdateTileInteraction before ticking the counter
 * at gGameStuff._unk14. */
void Scene06_Tick(u32 a, u32 b, u32 c)
{
    Entity_RunScript(0, a);
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Scene12_UpdateTileInteraction((void *)b, (void *)c);
    gGameStuff._unk14++;
}
