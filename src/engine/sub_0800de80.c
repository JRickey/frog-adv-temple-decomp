#include "game.h"
#include "sound.h"
#include "types.h"

extern void EntitySpawnDriver(void);
extern void WorldMap_Init(void);
extern void EntityProcE_Dispatch(void);
extern void ShowWinLoseMessage(u32 arg);
extern void Sound_Reset(void);

/* Mode-dispatched scene-step driver.
 *
 * Header: calls EntitySpawnDriver, EntityProcE_Dispatch, Sound_Reset, then clears
 * bit 1 (mask 0xFD) of the byte at 0x03003570 (gStructAt3003570.flags
 * — see src/game/sub_08020b30.c).
 *
 * First dispatch on gGameStuff.sceneType (1..16; out-of-range = no-op):
 *   modes 3, 6, 9, 12, 16 → Sound_PlayIfEnabled(1)
 *   all others 1..16     → Sound_PlayIfEnabled(2)
 *
 * Second dispatch on gGameStuff.sceneType (1..16; out-of-range = no-op):
 *   modes 3, 6, 9, 12, 16 → ShowWinLoseMessage(2)
 *   mode 15              → (skipped)
 *   all others 1..16     → ShowWinLoseMessage(1)
 *
 * Tail: bl WorldMap_Init, return.
 *
 * Matching notes (old_agbcc):
 *   - gGameStuff base is cached across the three opening BLs so
 *     sceneType materializes without a fresh pool load.
 *   - The second dispatch reads gGameStuff.sceneType via the macro
 *     (fresh pool load), not via the cached pointer — baserom reloads
 *     the base address before the second ldrb.
 *   - Each switch uses an explicit dense 1..16 case list so old_agbcc
 *     keeps the `subs #1; cmp #15; bhi default; lsls #2; ldr table` jump
 *     table instead of folding the four active cases into an if-chain.
 *   - Within each switch the arg-2 case group is listed FIRST. That puts
 *     the arg-2 body at the lower-address jump-table target (matching
 *     baserom's 0x0800def8 = arg=2, 0x0800df00 = arg=1).
 *   - The flags-clear is written `t = 0xFD; t &= p->flags; p->flags = t;`
 *     giving baserom's `ldr r1, =0x03003570; movs r0, #253;
 *     ldrb r2, [r1]; ands r0, r2; strb r0, [r1]` shape.
 */

typedef struct {
    u8 flags;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

void Game_FrameEnd(void)
{
    GameStuff *g;
    u8 t;

    g = &gGameStuff;

    EntitySpawnDriver();
    EntityProcE_Dispatch();
    Sound_Reset();

    {
        StructAt3003570 *p1 = &gStructAt3003570;
        t = 0xFD;
        t &= p1->flags;
        p1->flags = t;
    }

    switch (g->sceneType) {
    case 1:
    case 2:
    case 4:
    case 5:
    case 7:
    case 8:
    case 10:
    case 11:
    case 13:
    case 14:
    case 15:
        Sound_PlayIfEnabled(2);
        break;
    case 3:
    case 6:
    case 9:
    case 12:
    case 16:
        Sound_PlayIfEnabled(1);
        break;
    default:
        break;
    }

    switch (gGameStuff.sceneType) {
    case 1:
    case 2:
    case 4:
    case 5:
    case 7:
    case 8:
    case 10:
    case 11:
    case 13:
    case 14:
        ShowWinLoseMessage(1);
        break;
    case 3:
    case 6:
    case 9:
    case 12:
    case 16:
        ShowWinLoseMessage(2);
        break;
    case 15:
        break;
    default:
        break;
    }

    WorldMap_Init();
}
