#include "macros.h"
#include "types.h"

/* IntrDisable — disable IRQs by setting CPSR I-bit (bit 7).
 *
 * Pushes r0, reads CPSR, ORs 0x80, writes CPSR_fc, pops r0, returns.
 * Preserves all registers (r0 restored on exit).
 *
 * Shipped NAKED. This is an ARM-mode function — agbcc emits Thumb
 * code only, so there is no C compilation path to ARM-mode output.
 * The function additionally uses mrs/msr CPSR instructions which are
 * ARM-only and have no Thumb equivalent. */

#ifdef NON_MATCHING

void IntrDisable(void)
{
    /* Sets the I-bit in CPSR to disable IRQ interrupts. */
}

#else

NAKED void IntrDisable(void)
{
    asm(".syntax unified\n"
        "    .arm\n"
        "    stmfd   sp!, {r0}\n"
        "    mrs     r0, CPSR\n"
        "    orr     r0, r0, #0x80\n"
        "    msr     CPSR_fc, r0\n"
        "    ldmfd   sp!, {r0}\n"
        "    bx      lr\n"
        "    .syntax divided\n");
}

#endif /* NON_MATCHING */
