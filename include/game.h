#ifndef GUARD_GAME_H
#define GUARD_GAME_H

#include "types.h"

/* Game-state structure at 0x03005330 in IWRAM. Layout is being discovered
 * incrementally — fields named `_unkNN` are inferred from access width by
 * tools/agent/struct_grow.py; rename as their purpose is identified.
 *
 *  offset 9   `mode`         - AgbMain dispatches its 26-case switch on this byte.
 *                              AgbMain itself initializes it to 4 in its prologue
 *                              (mode 4 == "title screen" or similar, TBD).
 *  offset 10  `pendingMode`  - Written by Set*Mode_NN helpers (despite the name).
 *                              Purpose TBD; not directly dispatched. Hypothesis:
 *                              a queued / requested mode that propagates to
 *                              `mode` later via code we haven't decompiled yet.
 *  offset 28  `rngSeed`      - LCG state stepped by sub_08000764
 *                              (seed = seed * 109 + 1021).
 *  offset 34  `_unk22`       - halfword; written by sub_0801932C.
 *  offset 36  `_step24`      - 3-step cycle counter (0→1→2→0) used by
 *                              sub_0801793C to index gHandlerTable_08308028
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

#endif /* GUARD_GAME_H */
