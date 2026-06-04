#include "macros.h"
#include "types.h"

/* Thumb-callable interwork veneer for the ARM-mode sound-IRQ enable routine
 * at 0x08032e1c. The 8-byte body is `bx pc; nop; b 0x08032e1c`: the Thumb
 * `bx pc` switches to ARM mode at the next 4-byte-aligned instruction, the
 * `nop` pads to that boundary, and the ARM `b` tail-calls the target.
 *
 * The `bx pc` opcode has no C equivalent; the veneer body is hand-written.
 * The NON_MATCHING block documents intent for the phase-3 PC port. */

#ifdef NON_MATCHING
void sub_08035D94(void)
{
    /* Delegates to the ARM-mode sound-IRQ enable routine at 0x08032e1c. */
}
#else
NAKED void sub_08035D94(void)
{
    /* bx pc switches to ARM mode; .4byte encodes the ARM b 0x08032e1c directly
     * because the ARM branch offset is position-dependent (anchored at 0x08035d98). */
    asm(".syntax unified\n"
        "    bx      pc\n"
        "    nop\n"
        "    .arm\n"
        "    .4byte  0xeafff41f\n"
        "    .syntax divided\n");
}
#endif
