#include "game.h"
#include "iwram.h"

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void BgTilemap_LoadScreen(void);
extern void Game_FrameEnd(void);
extern u32 Scene_EntityTick(u8 *state);

void Mode_RunFrameBasic(void)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    gGameStuff._unk14++;
}

void State_ValidateOrReset(u8 *state)
{
    if (Scene_EntityTick(state) == 0)
        *state = 8;
}

void Mode_ReturnToMap(void)
{
    gEntities[0].field_17 = 2;
    BgTilemap_LoadScreen();
    Game_FrameEnd();
}
