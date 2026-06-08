#include "macros.h"
#include "types.h"

extern void Scroll_TickChannels(u8 a, u8 b);
extern void FrogStatusBar_Update(void);

void Engine_Update(void)
{
    Scroll_TickChannels(5, 3);
    FrogStatusBar_Update();
}
