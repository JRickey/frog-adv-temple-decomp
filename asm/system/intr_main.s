@ Shipped ARM runtime: BIOS-invoked IRQ dispatcher.
@ _start installs this address into INTR_VECTOR (0x03007FFC); the BIOS jumps
@ through that RAM vector on hardware IRQ entry. Keep this as assembly like
@ other GBA decomps: it saves/restores SPSR and switches CPU modes via CPSR.

        .include "asm/macros.inc"
        .syntax unified

        .equ PSR_MODE_MASK, 0x1f
        .equ PSR_SYS_MODE,  0x1f

        .equ REG_BASE,      0x04000000
        .equ REG_IE_OFFSET, 0x200
        .equ REG_IF_OFFSET, 0x202

        .equ IRQ_VBLANK,  (1 << 0)
        .equ IRQ_HBLANK,  (1 << 1)
        .equ IRQ_VCOUNT,  (1 << 2)
        .equ IRQ_TIMER0,  (1 << 3)
        .equ IRQ_TIMER1,  (1 << 4)
        .equ IRQ_TIMER2,  (1 << 5)
        .equ IRQ_TIMER3,  (1 << 6)
        .equ IRQ_SERIAL,  (1 << 7)
        .equ IRQ_DMA0,    (1 << 8)
        .equ IRQ_DMA1,    (1 << 9)
        .equ IRQ_DMA2,    (1 << 10)
        .equ IRQ_DMA3,    (1 << 11)
        .equ IRQ_KEYPAD,  (1 << 12)
        .equ IRQ_GAMEPAK, (1 << 13)

        arm_func_start IntrMain
        stmfd   sp!, {lr}
        mrs     r0, SPSR
        stmfd   sp!, {r0}
        mrs     r0, CPSR
        bic     r1, r0, #PSR_MODE_MASK
        orr     r1, r0, #PSR_SYS_MODE
        msr     CPSR_fc, r1
        stmfd   sp!, {r0, lr}
        mov     r3, #REG_BASE
        add     r3, r3, #REG_IE_OFFSET
        ldr     r2, [r3]
        and     r1, r2, r2, lsr #16
        ands    r0, r1, #IRQ_GAMEPAK
.LIntrMain_gamepakLoop:
        bne     .LIntrMain_gamepakLoop
        mov     r2, #0
        ands    r0, r1, #IRQ_VBLANK
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_HBLANK
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_VCOUNT
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_TIMER0
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_TIMER1
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_TIMER2
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_TIMER3
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_SERIAL
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_DMA0
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_DMA1
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_DMA2
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_DMA3
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #IRQ_KEYPAD
.LIntrMain_dispatch:
        strh    r0, [r3, #(REG_IF_OFFSET - REG_IE_OFFSET)]
        ldr     r1, .LIntrMain_intrTable
        add     r1, r1, r2
        ldr     r0, [r1]
        mov     lr, pc
        bx      r0
        ldmfd   sp!, {r0, lr}
        msr     CPSR_fc, r0
        ldmfd   sp!, {r0}
        msr     SPSR_fc, r0
        ldmfd   sp!, {lr}
        bx      lr

@ Shared literal pool. _start and sub_08000240 use fixed PC-relative offsets
@ into these words, so their positions are part of the runtime ABI.
.LIntrMain_biosVec:
        .word   0x03007FFC
.LIntrMain_agbMainPtr:
        .word   0x080002A5
.LIntrMain_intrTable:
        .word   0x08035D9C
.LIntrMain_word238:
        .word   0x082F9010
.LIntrMain_word23C:
        .word   0x0802FFD9
        arm_func_end IntrMain
