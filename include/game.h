#ifndef GUARD_GAME_H
#define GUARD_GAME_H

#include "types.h"

/* Game-state structure at 0x03005330 in IWRAM. Layout is being discovered
 * incrementally.
 *
 *  offset 9   `mode`         - AgbMain dispatches its 26-case switch on this byte.
 *                              AgbMain itself initializes it to 4 in its prologue
 *                              (mode 4 == "title screen" or similar, TBD).
 *  offset 10  `pendingMode`  - Written by Set*Mode_NN helpers (despite the name).
 *                              Purpose TBD; not directly dispatched. Hypothesis:
 *                              a queued / requested mode that propagates to
 *                              `mode` later via code we haven't decompiled yet.
 *
 * Other fields are unknown; padding is sized to leave the named offsets at
 * their real positions.
 */
typedef struct {
    u8 _pad0[9];
    u8 mode;
    u8 pendingMode;
} GameStuff;

#define gGameStuff (*(GameStuff *)0x03005330)

#endif /* GUARD_GAME_H */
