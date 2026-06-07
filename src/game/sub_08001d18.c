#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void EntityDispatch_RunFrame(void);

/* One of the mode-setup entries dispatched from Scene08_Main's
 * 14-case state machine. Installs config table 0x082f9a50 into the
 * gGameStuff_6110 cluster via the shared 6-arg setup helper, then
 * primes the post-setup state (SpriteAsset_LoadSheet(6, 0); EntityDispatch_RunFrame())
 * and clears halfword 0x36 of the 0x03006500 IWRAM block. */
void Scene06_Init(void)
{
    ModeControl_Init(&gIwram_6110, 0x80, 6, (const void *)0x082f9a50, 1, 5);
    SpriteAsset_LoadSheet(6, 0);
    EntityDispatch_RunFrame();
    {
        u16 *p = (u16 *)0x03006500;
        p[0x36 / 2] = 0;
    }
}
