#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Entity_UpdateHitboxSlots(u32 a, u32 b, u8 c);

extern void SpriteAsset_LoadSheet(u32 a, u32 b);
extern void EntityDispatch_RunFrame(void);

/* Thin wrapper around Entity_UpdateHitboxSlots — sets gGameStuff.pendingMode = 1 then
 * forwards the caller's two args with the constant third argument 18. */
void Scene08_StartIntro(u32 a, u32 b)
{
    gGameStuff.pendingMode = 1;
    Entity_UpdateHitboxSlots(a, b, 18);
}

/* Sibling of Scene_Init_04 / Scene06_Init: installs config table 0x082f998c
 * into the gGameStuff_6110 cluster via the shared 6-arg setup helper, then
 * runs two post-setup state primes (SpriteAsset_LoadSheet(0, 0); SpriteAsset_LoadSheet(1, 1))
 * before EntityDispatch_RunFrame(). */
void Scene08_InitModeControl(void)
{
    ModeControl_Init(&gIwram_6110, 0x64, 0, (const void *)0x082f998c, 1, 3);
    SpriteAsset_LoadSheet(0, 0);
    SpriteAsset_LoadSheet(1, 1);
    EntityDispatch_RunFrame();
}
