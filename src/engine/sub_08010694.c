#include "macros.h"
#include "gfx.h"
#include "types.h"

/* Fade/transition init helper. Sets the IWRAM countdown at 0x03006538
 * to 16 (the fade duration), clears REG_BLDCNT (no blend effects), and
 * installs `arg` as the REG_WININ value (window-in mask). The companion
 * Blend_StepFade ticks the countdown down each frame.
 *
 * Called from Scene11_AttractModeMain / mode_15 with arg=0xBF when entering a
 * fade-in transition. Returns the arg unchanged (callers ignore it). */

u16 Blend_StartFade(u16 arg)
{
    *(vu8 *)0x03006538 = 16;
    *(vu16 *)0x04000054 = 0;
    *(vu16 *)0x04000050 = arg;
    return arg;
}
