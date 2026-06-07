#include "gba/io.h"
#include "gfx.h"
#include "types.h"

/* Disables one of the four BG layers in REG_DISPCNT.
 *
 * BG-OFF counterpart to BgLayer_Enable: ANDs the inverse of the matching
 * DISPCNT_BG{0..3}_ON bit into REG_DISPCNT. Any other index is a no-op. */

void BgLayer_Disable(u8 layer)
{
    switch (layer) {
    case 0:
        REG_DISPCNT &= ~DISPCNT_BG0_ON;
        break;
    case 1:
        REG_DISPCNT &= ~DISPCNT_BG1_ON;
        break;
    case 2:
        REG_DISPCNT &= ~DISPCNT_BG2_ON;
        break;
    case 3:
        REG_DISPCNT &= ~DISPCNT_BG3_ON;
        break;
    }
}
