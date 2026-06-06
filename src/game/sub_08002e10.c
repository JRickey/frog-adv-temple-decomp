#include "game.h"
#include "iwram.h"
#include "types.h"

extern void SpriteAsset_LoadSheet(u32 a, u32 b);
extern void EntityDispatch_RunFrame(void);

void GameMode10_Init(void)
{
    ModeControl_Init(&gIwram_6110, 0x50, 10, (const void *)0x082f9cc0, 1, 0);
    SpriteAsset_LoadSheet(10, 0);
    EntityDispatch_RunFrame();
}

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s16 tileX, s16 tileY);
extern void TileArrival_UpdateModeFlags(u8 arg);

void GameMode10_Tick(void)
{
    struct IwramAt35E0 *p;
    u32 mask;

    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();

    p = &gIwram_35E0;
    mask = 0x10;
    mask &= p->_field_10;
    if (mask != 0) {
        TileArrival_UpdateModeFlags((u8)Tilemap_GetTileClass(p->_field_18, p->_field_19, p->_field_8, p->_field_A));
    }

    gGameStuff._unk14++;
}

extern u32 Scene_EntityTick(u8 *state);

void GameMode10_StateCallback(u8 *state)
{
    if (Scene_EntityTick(state) == 0)
        *state = 9;
}

extern void Game_FrameEnd(void);

void GameMode10_Cleanup(void)
{
    Game_FrameEnd();
}

void GameMode10_TileCheckTick(void)
{
    struct IwramAt35E0 *p;
    u32 mask;

    p = &gIwram_35E0;
    mask = 0x10;
    mask &= p->_field_10;
    if (mask != 0) {
        TileArrival_UpdateModeFlags((u8)Tilemap_GetTileClass(p->_field_18, p->_field_19, p->_field_8, p->_field_A));
    }
}
