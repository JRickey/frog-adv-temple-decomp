#include "types.h"

extern void Game_FrameEnd(void);

/* Thin forwarder to Game_FrameEnd — sibling of Scene08_FinishFrame, same shape
 * (push lr; bl Game_FrameEnd; pop r0; bx r0). Likely another mode-dispatch
 * "release / teardown" entry. */
void Scene06_Exit(void)
{
    Game_FrameEnd();
}
