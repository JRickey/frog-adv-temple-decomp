#include "game.h"

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void SpawnCycle_Update(u32 a0, u32 a1, u32 a2, u32 a3);

void sub_08005308(u32 a0, u32 a1, u32 a2, u32 a3)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    SpawnCycle_Update(a0, a1, a2, a3);
    gGameStuff._unk14++;
}
