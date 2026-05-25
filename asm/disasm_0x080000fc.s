@ IntrEnable: enable IRQs by clearing CPSR I-bit (bit 7).
@ Range:  [0x080000fc, 0x08000114)  (24 bytes, ARM)
@ Restores r0 on exit so callers see no clobber.

        .include "asm/macros.inc"
        .syntax unified

        arm_func_start IntrEnable
IntrEnable: @ 0x080000fc
        stmfd   sp!, {r0}
        mrs     r0, CPSR
        bic     r0, r0, #0x80           @ clear I (IRQ-disable) bit
        msr     CPSR_fc, r0
        ldmfd   sp!, {r0}
        bx      lr
        arm_func_end IntrEnable
