#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308AE0[])(void);

extern u16 gIwram_5398;

/* Dispatch through a ROM handler table indexed by gIwram_3480.menuStep.
 * Class-sibling of GameMode_Menu07 (which indexes gHandlerTable_08308AD4 by the
 * same byte); the indirect call lowers to `bl _call_via_r0` and the popped
 * lr lands in r0 before bx, discarding the handler's return value. */

void GameMode_Menu27(void)
{
    gHandlerTable_08308AE0[gIwram_3480.menuStep]();
}

/* Mode-reset helper at 0x08020208 — shares this compilation slice with
 * GameMode_Menu27 (not reached by any ROM BL; kept as a separate symbol so the
 * surrounding layout stays byte-identical). Snaps the game back to mode 4,
 * clears dispatcher state bytes, and sets _data[20] = 2. */
void Dispatcher_ResetModeA(void)
{
    gGameStuff.mode = GAME_MODE_ROUTER;
    gIwram_3480.subState = 8;
    gIwram_3480.cursorIndex = 2;
    gIwram_5398 = 0;
    gIwram_3480.menuStep = 0;
    gIwram_3480.routerSelection = 0;
    gIwram_34A0._field_00 = 0;
}

/* Mode-reset helper at 0x0802023c — shares this compilation slice with
 * GameMode_Menu27 (not reached by any ROM BL; kept as a separate symbol so the
 * surrounding layout stays byte-identical). Snaps the game back to mode 4,
 * clears dispatcher state bytes, sets _data[20] = 1, and clears
 * gIwram_34A0.dispatchIdx. */
void Dispatcher_ResetModeB(void)
{
    gGameStuff.mode = GAME_MODE_ROUTER;
    gIwram_3480.subState = 8;
    gIwram_3480.cursorIndex = 1;
    gIwram_5398 = 0;
    gIwram_3480.menuStep = 0;
    gIwram_3480.routerSelection = 0;
    gIwram_34A0.dispatchIdx = 0;
}

void Dispatcher_ResetModeC(void)
{
    gGameStuff.mode = GAME_MODE_ROUTER;

    gIwram_3480.subState = 4;
    gIwram_3480.routerSelection = 0;
    gIwram_3480.menuStep = 0;
    gIwram_3480._unk01 = 0;

    gIwram_5398 = 0;

    gIwram_3480.reloadFlag = 1;
    gIwram_3480.blinkCounter = 0;

    Blend_StartFade(0xBF);
}
