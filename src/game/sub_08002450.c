#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void SpriteAsset_LoadSheet(u32 a, u32 b);
extern void EntityDispatch_RunFrame(void);

void sub_08002450(void)
{
    ModeControl_Init(&gIwram_6110, 0x19, 7, (const void *)0x082f9bf0, 1, 0);
    SpriteAsset_LoadSheet(7, 0);
    EntityDispatch_RunFrame();
}

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcD[17];

extern void Game_UpdateSubsystems(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Entity_CollisionProbe(void *obj, void *r4_obj);

void Scene_FrameUpdate(void *arg0, void *arg1)
{
    GameStuff *g;
    register u8 id asm("r2");
    register u32 offset asm("r0");

    Game_UpdateSubsystems();

    {
        const GameProc *procs = sEntityProcB;

        g = &gGameStuff;
        id = g->pendingMode;
        offset = id << 2;
        offset += (u32)procs;
        (*(GameProc *)offset)();
    }

    {
        const GameProc *procsD = sEntityProcD;

        id = g->pendingMode;
        offset = id << 2;
        offset += (u32)procsD;
        (*(GameProc *)offset)();
    }

    Entity_UpdateVisibility();
    Entity_Advance();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Entity_CollisionProbe(arg0, arg1);
    g->_unk14++;
}

extern u32 Scene_EntityTick(u8 *state);
extern void EntitySlot17_Init(void);

void Scene_CleanupOnExit(u8 *state)
{
    u8 *base;
    u32 zero;
    u8 *addr;

    if (Scene_EntityTick(state) == 0)
        *state = 8;
    base = (u8 *)0x03006110;
    addr = base + 42;
    zero = 0;
    *addr = (u8)zero;
    *(u16 *)(base + 12) = (u16)zero;
    if (*(base + 43) == 1)
        EntitySlot17_Init();
}
