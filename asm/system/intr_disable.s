@ Shipped ARM runtime: disable CPU IRQ delivery by setting CPSR.I.
@ This is CPU status-register code, not GBA MMIO interrupt-controller code.

        .include "asm/macros.inc"
        .syntax unified

        .equ PSR_I_BIT, 0x80

        arm_func_start IntrDisable
        stmfd   sp!, {r0}
        mrs     r0, CPSR
        orr     r0, r0, #PSR_I_BIT
        msr     CPSR_fc, r0
        ldmfd   sp!, {r0}
        bx      lr
        arm_func_end IntrDisable
