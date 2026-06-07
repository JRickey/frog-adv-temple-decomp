#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* --- EntitySpawnDriver: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

#define SPAWN_FLAG_DONE    1
#define SPAWN_FLAG_WAITING 2

typedef struct EntityInitDesc {
    s8 spawnCount;
    u8 settleLimit;
    u8 waitLimit;
    u8 _pad3;
    const s16 *points;
} EntityInitDesc;

extern const EntityInitDesc sEntityInitTable[];

extern void Game_UpdateSubsystems(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
/* s16 (NOT u16) params -> register-offset ldrsh at the call site -> correct 304 B size */
extern u32 Scroll_StepTowardTile(s16 x, s16 y);

void EntitySpawnDriver(void)
{
    u8 flags;
    u32 origin;
    s8 i;
    u8 result;

    flags = 0;
    origin = gGameStuff._unk00;

    while ((gGameStuff._unk00 - origin) < sEntityInitTable[gGameStuff.sceneType].settleLimit &&
           gEntities[0].state <= 3) {
        Game_UpdateSubsystems();
        Game_RunEntityFrame();
        WaitVblank();
        Game_ForceRender();
    }

    if (sEntityInitTable[gGameStuff.sceneType].spawnCount == 0) {
        return;
    }

    for (i = 0; i < sEntityInitTable[gGameStuff.sceneType].spawnCount; i++) {
        flags &= ~SPAWN_FLAG_DONE;
        while ((flags & SPAWN_FLAG_DONE) == 0) {
            if (flags & SPAWN_FLAG_WAITING) {
                if ((gGameStuff._unk00 - origin) > sEntityInitTable[gGameStuff.sceneType].waitLimit) {
                    flags &= ~SPAWN_FLAG_WAITING;
                }
            } else {
                const s16 *points = sEntityInitTable[gGameStuff.sceneType].points + i * 2;
                result = (u8)Scroll_StepTowardTile(points[0], points[1]);
                if (result == 0xff) {
                    origin = gGameStuff._unk00;
                    flags |= SPAWN_FLAG_WAITING;
                }
                if (result == 1) {
                    flags |= SPAWN_FLAG_DONE;
                }
            }
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
        }
    }
}
#else
NAKED void EntitySpawnDriver(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0xdc50, 0x130\n");
}
#endif /* NON_MATCHING */
