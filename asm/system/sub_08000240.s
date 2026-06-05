@ Shipped ARM runtime helper after IntrMain.
@ Uses IntrMain's shared literal pool at 0x08000238 / 0x0800023C.

        .include "asm/macros.inc"
        .syntax unified

        .equ REG_BASE,      0x04000000
        .equ REG_IE_OFFSET, 0x200
        .equ IRQ_VBLANK,    (1 << 0)
        .equ PSR_I_BIT,     0x80

        arm_func_start sub_08000240
        stmfd   sp!, {lr}
        ldr     r3, [pc, #-20]
        ldr     r2, [r3]
        cmp     r2, #0
        beq     .Lsub_08000240_callOnly
        mov     r0, #REG_BASE
        ldr     r1, [r0, #REG_IE_OFFSET]
        push    {r0, r1}
        bic     r1, r1, #IRQ_VBLANK
        str     r1, [r0, #REG_IE_OFFSET]
        mrsne   r0, CPSR
        bicne   r0, r0, #PSR_I_BIT
        msrne   CPSR_fc, r0
        ldr     r0, [pc, #-64]
        mov     lr, pc
        bx      r0
        pop     {r0, r1}
        str     r1, [r0, #REG_IE_OFFSET]
        ldmfd   sp!, {lr}
        bx      lr

.Lsub_08000240_callOnly:
        ldr     r0, [pc, #-92]
        mov     lr, pc
        bx      r0
        ldmfd   sp!, {lr}
        bx      lr
        arm_func_end sub_08000240
