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
 *  offset 10  `sceneType`     - scene/level id (was the misnomer `pendingMode`;
 *                              NOT a queued game mode). Scene handlers set it to
 *                              `mode - 7`; ModeControl/Game_FrameEnd dispatch on
 *                              it; it keys the sEntityProc* tables in
 *                              src/data/entity_dispatch.c. The Set*Mode_NN
 *                              helpers set this scene id.
 *  offset 12  `unlockedWorlds`       - unlocked-worlds bitmap (set by WorldMap_Init;
 *                              read by GetHighestUnlockedWorld to bound the world map).
 *  offset 28  `rngSeed`      - LCG state stepped by RandRange
 *                              (seed = seed * 109 + 1021).
 *  offset 34  `_unk22`       - halfword; written by TitleLogo_Display.
 *  offset 36  `attractStep`      - 3-step cycle counter (0→1→2→0) used by
 *                              GameMode_Attract to index gHandlerTable_08308028
 *                              and select a sceneType value.
 */
/* Part source-record layout (16 bytes). Used by EntityScript_BuildSlotData and
 * LoadPartEntry. _b6/_b7 encode the layout flag and axis id; LoadPartEntry does
 * not access them but the same physical bytes exist (replaced by _pad in its
 * simpler variant — same size, same alignment). */
struct SrcRec {
    s16 _h0;
    s16 _h2;
    s8 _b4;
    s8 _b5;
    s8 _b6;
    s8 _b7;
    u8 _b8;
    u8 _b9;
    u8 _pad[2];
    u32 _w12;
};

/* Part-descriptor table entry (0x080C0AB0 / 0x080C0AE8). */
struct PartEntry {
    s8 count;
    u8 _b1;
    u8 _pad[2];
    const struct SrcRec *records;
};

/* Per-script header record (sEntityScriptIndex table). */
struct EntScript {
    s8 count; /* +0: signed loop bound */
    u8 _b1;
    s8 _b2;
    u8 _b3;
    const void *script; /* +4 */
};

typedef struct GameStuff {
    u32 _unk00;
    u32 _unk04;
    u8 _pad08[1];
    u8 mode;
    u8 sceneType;
    u8 _pad0B[1];
    u32 unlockedWorlds;
    u8 _unk10;
    u8 _pad11[3];
    u32 _unk14;
    u8 _unk18;
    u8 _pad19[3];
    u32 rngSeed;
    u8 _pad20[2];
    u16 _unk22;
    u8 attractStep;
} GameStuff;

#define gGameStuff (*(GameStuff *)0x03005330)

void UpdateSceneGate(u8 mode);

u32 Timer_SetIrqHandler(u8 idx, void *out);

u32 Scene_EntityTick(u8 *flag);

s32 GetVcountRandom(u8 range);

s32 Scene08_MapScreenTick(void);

void WaitFrames(u32 delay);

/* Both params are entity/object pointers; void* avoids pointer-type drift
 * across callers that receive them typed as u32. */
void Scene12_UpdateTileInteraction(void *buf, void *r4_obj);

void Player_HandleTileTransitions(void *a, void *b);

#endif /* GUARD_GAME_H */
