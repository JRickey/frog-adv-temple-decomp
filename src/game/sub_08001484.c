#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void EntityDispatch_RunFrame(void);

/* Sibling of Scene06_Init (one of the mode-setup entries). Installs
 * config table 0x082f9be0 into the gGameStuff_6110 cluster via the
 * shared 6-arg setup helper, then primes the post-setup state
 * (SpriteAsset_LoadSheet(4, 0); EntityDispatch_RunFrame()). Unlike Scene06_Init it does
 * not clear the 0x03006500 halfword afterwards. */
void Scene_Init_04(void)
{
    ModeControl_Init(&gIwram_6110, 0x50, 4, (const void *)0x082f9be0, 1, 0);
    SpriteAsset_LoadSheet(4, 0);
    EntityDispatch_RunFrame();
}
