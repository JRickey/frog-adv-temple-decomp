#include "types.h"
#include "game.h"

extern u32 GetFrameTick(void);

/* Busy-waits until the frame counter (GetFrameTick) has advanced by at least
 * `delay` ticks since entry. */
void WaitFrames(u32 delay)
{
    u32 start = GetFrameTick();

    while (GetFrameTick() - start < delay) {
    }
}
