@ IntrDisable: disable IRQs by setting CPSR I-bit (bit 7).
@ Range:  [0x08000114, 0x0800012c)  (24 bytes, ARM)
@ Restores r0 on exit so callers see no clobber.

        .include "asm/macros.inc"
        .syntax unified

        arm_func_start IntrDisable
IntrDisable: @ 0x08000114
        stmfd   sp!, {r0}
        mrs     r0, CPSR
        orr     r0, r0, #0x80           @ set I (IRQ-disable) bit
        msr     CPSR_fc, r0
        ldmfd   sp!, {r0}
        bx      lr
        arm_func_end IntrDisable
