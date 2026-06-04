#include "types.h"
#include "macros.h"

/* Thumb-callable interwork veneer: switches to ARM mode and branches
 * to the sound-IRQ disable routine (SoundIrqDisable_ARM at 0x08032e38).
 * The `bx pc` + `nop` is the standard Thumb-to-ARM interwork preamble;
 * there is no C construct agbcc can lower to this shape. */
extern void SoundIrqDisable_ARM(void);

NAKED void sub_08035D8C(void)
{
    asm(".syntax unified\n"
        "    bx      pc\n"
        "    nop\n"
        "    .code   32\n"
        "    b       SoundIrqDisable_ARM\n"
        "    .syntax divided\n");
}
