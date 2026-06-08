#include "game.h"

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void SpawnCycle_Update(u32 a0, u32 a1, u32 a2, u32 a3);

void Game_StepFrame(u32 spawnArg0, u32 spawnArg1, u32 spawnArg2, u32 spawnArg3)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    SpawnCycle_Update(spawnArg0, spawnArg1, spawnArg2, spawnArg3);
    gGameStuff._unk14++;
}
