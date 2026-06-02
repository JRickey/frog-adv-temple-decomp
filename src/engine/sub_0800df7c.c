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

extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern int sub_08013694(void);
extern u8 sub_0800A104(s8 *phase, u32 callbackTable);

void sub_0800DFAC(void)
{
    u8 done = 0;
    s8 state = done;

    while (sub_0800A104(&state, 0x0800DF9D) == 0) {
        sub_080008DC();
    }

    while (!(done & 1)) {
        sub_080008DC();
        if (sub_08013694() != 0)
            done |= 1;
        sub_08009A58();
        sub_08009188();
        sub_0800A328();
    }
}
