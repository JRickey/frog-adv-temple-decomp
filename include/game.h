#ifndef GUARD_GAME_H
#define GUARD_GAME_H

#include "types.h"

#include "constants/game_mode.h"

/* Game-state structure at 0x03005330 in IWRAM. Layout is being discovered
 * incrementally — fields named `_unkNN` are inferred from access width by
 * tools/agent/struct_grow.py; rename as their purpose is identified.
 *
 *  offset 9   `mode`         - AgbMain dispatches its switch on this byte; the
 *                              values are `enum GameMode`. AgbMain initializes
 *                              it to GAME_MODE_ROUTER (4), the central hub that
 *                              every screen returns to. See
 *                              include/constants/game_mode.h.
 *  offset 10  `pendingMode`  - MISNAMED. Not a queued game mode: it is a
 *                              scene/entity-type id (the scene handlers set it
 *                              to `mode - 7` and ModeControl/Game_FrameEnd
 *                              dispatch on it; it also keys the sEntityProc*
 *                              tables in src/data/entity_dispatch.c). The
 *                              Set*Mode_NN helpers actually set this scene id.
 *                              Rename pending (-> SetSceneType_NN); see
 *                              docs/unknowns.md.
 *  offset 12  `_unk0C`       - unlocked-worlds bitmap (set by WorldMap_Init;
 *                              read by GetHighestUnlockedWorld to bound the world map).
 *  offset 28  `rngSeed`      - LCG state stepped by RandRange
 *                              (seed = seed * 109 + 1021).
 *  offset 34  `_unk22`       - halfword; written by TitleLogo_Display.
 *  offset 36  `_step24`      - 3-step cycle counter (0→1→2→0) used by
 *                              GameMode_Attract to index gHandlerTable_08308028
 *                              and select a pendingMode value.
 */
typedef struct GameStuff {
    u32 _unk00;
    u32 _unk04;
    u8 _pad08[1];
    u8 mode;
    u8 pendingMode;
    u8 _pad0B[1];
    u32 _unk0C;
    u8 _unk10;
    u8 _pad11[3];
    u32 _unk14;
    u8 _unk18;
    u8 _pad19[3];
    u32 rngSeed;
    u8 _pad20[2];
    u16 _unk22;
    u8 _step24;
} GameStuff;

#define gGameStuff (*(GameStuff *)0x03005330)

void UpdateSceneGate(u8 mode);

u32 Timer_SetIrqHandler(u8 idx, void *out);

u32 Scene_EntityTick(u8 *flag);

#endif /* GUARD_GAME_H */
