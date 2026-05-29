#include "gba/io.h"
#include "types.h"

extern void sub_0800EE34(u8 layer);

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

/* Resets REG_DISPCNT to OBJ-only (1D mapping) and reconfigures the BG
 * layers for display mode `mode`. Modes 1 and 2 share a trailing
 * BG2-off / BG3-on tail (agbcc tail-merges it into one block, so mode 1
 * branches into the middle of mode 2's body):
 *   mode 1 -> BG0 on, BG1 off, BG2 off, BG3 on;
 *   mode 2 -> BG0 on, BG1 on,  BG2 off, BG3 on;
 *   mode 3 -> BG0..BG3 all on.
 * Other modes leave only the OBJ bits set. */

void sub_0800EEE8(u8 mode)
{
    REG_DISPCNT = DISPCNT_OBJ_ON | DISPCNT_OBJ_1D;

    switch (mode) {
    case 1:
        sub_0800EE94(0);
        sub_0800EE34(1);
        sub_0800EE34(2);
        sub_0800EE94(3);
        break;
    case 2:
        sub_0800EE94(0);
        sub_0800EE94(1);
        sub_0800EE34(2);
        sub_0800EE94(3);
        break;
    case 3:
        sub_0800EE94(0);
        sub_0800EE94(1);
        sub_0800EE94(2);
        sub_0800EE94(3);
        break;
    }
}
