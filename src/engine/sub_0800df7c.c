#include "game.h"
#include "types.h"

/* Sole caller of sEntityProcE — dispatches the per-entity-type "E" handler
 * (cleanup callback) by gGameStuff.pendingMode. See src/data/entity_dispatch.c
 * for the table layout (5 parallel 17-entry function-pointer tables).
 *
 * The indirect call lowers to `bl _call_via_r0` (libgcc thunk at 0x08033cd8)
 * — agbcc's standard Thumb function-pointer call sequence. */

typedef void (*GameProc)(void);

extern const GameProc sEntityProcE[17];

void sub_0800DF7C(void)
{
    sEntityProcE[gGameStuff.pendingMode]();
}

extern void sub_0800A05C(void);
extern void sub_08013880(void);

void sub_0800DF9C(void)
{
    sub_0800A05C();
    sub_08013880();
}
