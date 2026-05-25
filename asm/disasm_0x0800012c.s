@ IntrMain: BIOS-invoked IRQ dispatcher. Installed at 0x03007FFC by _start.
@
@ Saves SPSR + caller's CPSR, drops into SYS mode (privileged but with the
@ IRQ banked registers no longer aliasing), then reads REG_IE_IF
@ (0x04000200) to find the IE & IF intersection. If the GAMEPAK bit
@ (1<<13) is set, lock the system (cart removal). Otherwise it unrolls a
@ bit-scan over IRQ bits 0..12 (VBlank..KEYPAD), computes a word-aligned
@ index, acks the matched bit into REG_IF, and tail-calls the handler at
@ gIntrTable[index]. On return it unwinds the mode change and returns.
@
@ Range:  [0x0800012c, 0x08000240)  (276 bytes, ARM)
@ Code = [0x12c, 0x22c); literal pool = [0x22c, 0x240).
@
@ The literal pool at the tail is SHARED — _start (0xD8, 0xE4) and
@ sub_08000240 (0x244, 0x274, 0x290) reach into it via raw [pc, #N]
@ offsets that bake in IntrMain's address. Don't rearrange these words.

        .include "asm/macros.inc"
        .syntax unified

        arm_func_start IntrMain
IntrMain: @ 0x0800012c
        stmfd   sp!, {lr}
        mrs     r0, SPSR
        stmfd   sp!, {r0}
        mrs     r0, CPSR
        bic     r1, r0, #0x1f                   @ clear mode bits in r1
        orr     r1, r0, #0x1f                   @ ... and OR them to SYS mode (0x1f)
        msr     CPSR_fc, r1                     @ enter SYS mode (no IRQ-bank aliasing)
        stmfd   sp!, {r0, lr}
        mov     r3, #0x04000000                 @ REG_BASE
        add     r3, r3, #0x200                  @ r3 = &REG_IE
        ldr     r2, [r3]                        @ r2 = (REG_IF << 16) | REG_IE
        and     r1, r2, r2, lsr #16             @ r1 = IE & IF
        ands    r0, r1, #(1 << 13)              @ INTR_GAMEPAK -> cart removed
.LIntrMain_gamepakLoop:
        bne     .LIntrMain_gamepakLoop          @ lock forever if cart pulled
        mov     r2, #0                          @ r2 = handler-table byte offset
        ands    r0, r1, #(1 << 0)               @ VBlank
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 1)               @ HBlank
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 2)               @ VCount
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 3)               @ Timer0
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 4)               @ Timer1
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 5)               @ Timer2
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 6)               @ Timer3
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 7)               @ Serial
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 8)               @ DMA0
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 9)               @ DMA1
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 10)              @ DMA2
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 11)              @ DMA3
        bne     .LIntrMain_dispatch
        add     r2, r2, #4
        ands    r0, r1, #(1 << 12)              @ KEYPAD (last; falls through)
.LIntrMain_dispatch:
        strh    r0, [r3, #2]                    @ ack matched bit -> REG_IF
        ldr     r1, .LIntrMain_intrTable        @ &gIntrTable
        add     r1, r1, r2                      @ &gIntrTable[idx]
        ldr     r0, [r1]                        @ handler fn
        mov     lr, pc
        bx      r0                              @ call handler
        ldmfd   sp!, {r0, lr}                   @ restore caller CPSR + lr
        msr     CPSR_fc, r0
        ldmfd   sp!, {r0}                       @ restore SPSR
        msr     SPSR_fc, r0
        ldmfd   sp!, {lr}
        bx      lr
@ Shared literal pool — see header. Order is load-bearing; the raw
@ [pc, #N] offsets in _start and sub_08000240 assume these exact slots.
.LIntrMain_biosVec:
        .word   0x03007FFC                      @ 0x0800022c
.LIntrMain_agbMainPtr:
        .word   0x080002A5                      @ 0x08000230  (thumb ptr to AgbMain)
.LIntrMain_intrTable:
        .word   0x08035D9C                      @ 0x08000234  (gIntrTable)
.LIntrMain_word238:
        .word   0x082F9010                      @ 0x08000238  (used by sub_08000240)
.LIntrMain_word23C:
        .word   0x0802FFD9                      @ 0x0800023c  (thumb fn used by sub_08000240)
        arm_func_end IntrMain
