#include "gba/io.h"
#include "types.h"

/* Enables one of the four BG layers in REG_DISPCNT.
 *
 * Layer index 0..3 maps to DISPCNT_BG0_ON..DISPCNT_BG3_ON. Any other
 * index is a no-op return.
 *
 * Used during the title/scene teardown in sub_0800FD50 (calls with 3)
 * to re-enable BG3 after the blend/window registers are cleared. */

void sub_0800EE94(u8 layer)
{
    switch (layer) {
    case 0:
        REG_DISPCNT |= DISPCNT_BG0_ON;
        break;
    case 1:
        REG_DISPCNT |= DISPCNT_BG1_ON;
        break;
    case 2:
        REG_DISPCNT |= DISPCNT_BG2_ON;
        break;
    case 3:
        REG_DISPCNT |= DISPCNT_BG3_ON;
        break;
    }
}
