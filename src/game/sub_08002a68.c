#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void SpriteAsset_LoadSheet(u32 a, u32 b);
extern void EntityDispatch_RunFrame(void);

void Mode9_Init(void)
{
    ModeControl_Init(&gIwram_6110, 0x64, 9, (const void *)0x082f9ab8, 1, 5);
    SpriteAsset_LoadSheet(9, 0);
    EntityDispatch_RunFrame();
}

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);

void Mode9_Update(void)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    gGameStuff._unk14++;
}

extern u32 Scene_EntityTick(u8 *state);

void Mode9_AdvanceState(u8 *state)
{
    if (Scene_EntityTick(state) == 0)
        *state = 7;
}
