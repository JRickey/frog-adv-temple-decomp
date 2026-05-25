@ sub_08000240: VBlank-IRQ-wait-style helper.
@
@ Reads a flag word at 0x082F9010. If non-zero, it temporarily disables
@ the VBlank IRQ in REG_IE, re-enables IRQs globally (CPSR I-bit clear),
@ then calls the thumb handler at 0x0802FFD8 (loaded via the shared
@ literal pool word at 0x0800023C). On return, REG_IE is restored. If
@ the flag is zero, it skips all IRQ wrangling and just calls the same
@ handler.
@
@ Range:  [0x08000240, 0x080002a4)  (100 bytes, ARM)
@ Reaches BACKWARD into IntrMain's literal pool: [pc, #-20] -> 0x238,
@ [pc, #-64]/[pc, #-92] -> 0x23c. Don't move IntrMain or this slice.
@ Names "sub_08000240" until the thumb handler is decompiled and its
@ purpose is named.

        .include "asm/macros.inc"
        .syntax unified

        arm_func_start sub_08000240
sub_08000240: @ 0x08000240
        stmfd   sp!, {lr}
        ldr     r3, [pc, #-20]          @ -> word at 0x08000238 = 0x082F9010 (state flag)
        ldr     r2, [r3]
        cmp     r2, #0
        beq     .Lsub_08000240_callOnly
        mov     r0, #0x04000000         @ REG_BASE
        ldr     r1, [r0, #0x200]        @ r1 = REG_IE
        stmfd   sp!, {r0, r1}
        bic     r1, r1, #(1 << 0)       @ disable VBlank IRQ
        str     r1, [r0, #0x200]
        mrsne   r0, CPSR                @ NE (r2 != 0) preserved through stack ops above
        bicne   r0, r0, #0x80           @ enable IRQs globally
        msrne   CPSR_fc, r0
        ldr     r0, [pc, #-64]          @ -> word at 0x0800023C = 0x0802FFD9 (thumb handler)
        mov     lr, pc
        bx      r0
        ldmfd   sp!, {r0, r1}
        str     r1, [r0, #0x200]        @ restore REG_IE
        ldmfd   sp!, {lr}
        bx      lr
.Lsub_08000240_callOnly:
        ldr     r0, [pc, #-92]          @ -> word at 0x0800023C = 0x0802FFD9
        mov     lr, pc
        bx      r0
        ldmfd   sp!, {lr}
        bx      lr
        arm_func_end sub_08000240
