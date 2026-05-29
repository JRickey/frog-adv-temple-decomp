#include "types.h"

extern u32 sub_08000900(void);

/* Busy-waits until the frame counter (sub_08000900) has advanced by at least
 * `delay` ticks since entry. */
void sub_0801E270(u32 delay)
{
    u32 start = sub_08000900();

    while (sub_08000900() - start < delay) {
    }
}
