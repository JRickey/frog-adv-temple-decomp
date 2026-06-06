#include "game.h"
#include "types.h"

extern void Game_FrameEnd(void);
extern u8 Screen_FadeSequence(u8 arg);
extern void BgScroll_TileWipeTransition(void);

void Scene_ExitSequence(void)
{
    Game_FrameEnd();
    Screen_FadeSequence(0);
    BgScroll_TileWipeTransition();
}
