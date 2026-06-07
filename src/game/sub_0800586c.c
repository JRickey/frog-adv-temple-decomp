#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void SpriteAsset_LoadSheet(u32 a, u32 b);
extern void EntityDispatch_RunFrame(void);

extern void Entity_InitHitboxSlots(u32 arg);

void Stage_InitMode16(u32 arg)
{
    gGameStuff.pendingMode = 16;
    Entity_InitHitboxSlots(arg);
    gIwram_6110.spawnMask = 0;
}

void Stage_InitMode17(void)
{
    struct IwramAt6110 *p = &gIwram_6110;
    ModeControl_Init(p, 0x50, 17, (const void *)0x082f9cf0, 1, 0);
    SpriteAsset_LoadSheet(17, 0);
    EntityDispatch_RunFrame();
    p->scenePhase = 4;
}

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Entity_UpdateHitAndDraw(u32 arg);

void Stage_UpdateTick(u32 arg)
{
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Entity_UpdateHitAndDraw(arg);
    gGameStuff._unk14++;
}

extern void ModeControl_ClearBit(u32 base, u32 idx, u32 val);

void Stage_ResetPlayerSlots(u8 *state, u32 arg)
{
    u8 *base;
    u8 *p;
    s8 i;

    if (Scene_EntityTick(state) == 0) {
        *state = 9;
    }
    Entity_InitHitboxSlots(arg);
    base = (u8 *)0x03006110;
    base[0x2a] = 0;
    ModeControl_ClearBit((u32)base, 5, 4);
    i = 0;
    p = base;
    for (; i <= 3; i++) {
        if (!((p[0x33] >> i) & 1)) {
            ModeControl_ClearBit((u32)p, 5, (u8)i);
        }
    }
}

extern void Stage_BuildActiveSlotMask(void);
extern void Game_UpdateSubsystems(void);

void Stage_WaitAndResetSpawnFlags(void)
{
    Stage_BuildActiveSlotMask();
    while ((u8)ModeControl_GetFlag((u8 *)0x03006110, 8, 2) == 0) {
        Game_UpdateSubsystems();
        Game_RunEntityFrame();
        WaitVblank();
        Game_ForceRender();
    }
    {
        u8 *base = (u8 *)0x03006110;
        ModeControl_ClearBit((u32)base, 8, 2);
        base[0x2a] = 0;
        ModeControl_ClearBit((u32)base, 5, 4);
    }
}
