#include "gba/intr.h"
#include "macros.h"
#include "types.h"

/* sub_08000240 — VBlank-IRQ-wait-style dispatch helper.
 *
 * Reads a flag word at 0x082F9010 (shared with IntrMain's literal pool
 * at 0x08000238 via a raw [pc,#-20] load). If non-zero:
 *   - Reads REG_IE (0x04000200) and saves it on the stack.
 *   - Clears VBlank bit (bit 0) in REG_IE.
 *   - Enables global IRQs (clears CPSR I-bit) via mrsne/msrne.
 *   - Calls the Thumb handler at 0x0802FFD8 (pool word at 0x0800023C,
 *     reached by [pc,#-64] / [pc,#-92]).
 *   - Restores REG_IE.
 * If zero: calls the handler directly with no IRQ wrangling.
 *
 * Shipped NAKED. This is an ARM-mode function — agbcc emits Thumb
 * code only, so there is no C compilation path to ARM-mode output.
 * The function additionally uses conditional CPSR manipulation
 * (mrsne / msrne) and backward PC-relative loads into IntrMain's
 * shared literal pool, both of which require hand-written ARM asm.
 *
 * The NON_MATCHING body below documents intent for the phase-3 PC port.
 */

#ifdef NON_MATCHING

extern volatile u32 gUnk_082F9010;
extern void sub_0802FFD8(void);

void sub_08000240(void)
{
    u32 flag = gUnk_082F9010;

    if (flag != 0) {
        u32 reg_base = 0x04000000;
        u16 saved_ie = *(volatile u16 *)(reg_base + 0x200);
        *(volatile u16 *)(reg_base + 0x200) = saved_ie & ~IRQ_VBLANK;
        /* enable global IRQs by clearing CPSR I-bit — requires ARM mrsne/msrne */
        sub_0802FFD8();
        *(volatile u16 *)(reg_base + 0x200) = saved_ie;
    } else {
        sub_0802FFD8();
    }
}

#else

NAKED void sub_08000240(void)
{
    asm(".syntax unified\n"
        "    .arm\n"
        "    stmfd   sp!, {lr}\n"
        "    ldr     r3, [pc, #-20]\n" /* -> 0x08000238 = gUnk_082F9010 */
        "    ldr     r2, [r3]\n"
        "    cmp     r2, #0\n"
        "    beq     .Lsub_08000240_callOnly\n"
        "    mov     r0, #0x04000000\n"  /* REG_BASE */
        "    ldr     r1, [r0, #0x200]\n" /* r1 = REG_IE */
        "    push    {r0, r1}\n"
        "    bic     r1, r1, #1\n"       /* clear VBlank IRQ bit */
        "    str     r1, [r0, #0x200]\n" /* REG_IE &= ~IRQ_VBLANK */
        "    mrsne   r0, CPSR\n"         /* NE held from cmp r2,#0 */
        "    bicne   r0, r0, #0x80\n"    /* clear I-bit (enable IRQs globally) */
        "    msrne   CPSR_fc, r0\n"
        "    ldr     r0, [pc, #-64]\n" /* -> 0x0800023C = sub_0802FFD9 */
        "    mov     lr, pc\n"
        "    bx      r0\n"
        "    pop     {r0, r1}\n"
        "    str     r1, [r0, #0x200]\n" /* restore REG_IE */
        "    ldmfd   sp!, {lr}\n"
        "    bx      lr\n"
        ".Lsub_08000240_callOnly:\n"
        "    ldr     r0, [pc, #-92]\n" /* -> 0x0800023C = sub_0802FFD9 */
        "    mov     lr, pc\n"
        "    bx      r0\n"
        "    ldmfd   sp!, {lr}\n"
        "    bx      lr\n"
        "    .syntax divided\n");
}

#endif /* NON_MATCHING */
