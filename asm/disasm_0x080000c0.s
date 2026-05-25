@ ARM crt0 entry. Branched to from the cartridge header at 0x080000A8 on
@ power-up / soft-reset. Sets up the supervisor- and IRQ-mode stacks,
@ installs IntrMain (at 0x0800012C) as the BIOS IRQ handler, then calls
@ the first Thumb function (AgbMain @ 0x080002A4) via the pointer stored
@ at 0x08000230. If AgbMain returns, infinite-loops back to entry.
@
@ Range:  [0x080000c0, 0x080000fc)  (60 bytes, ARM)
@ Two of the LDRs reach into IntrMain's literal pool at 0x0800022C and
@ 0x08000230 via raw [pc, #N] offsets — those constants live alongside
@ IntrMain rather than _start, so they're referenced positionally here.

        .include "asm/macros.inc"
        .syntax unified

        arm_func_start _start
_start: @ 0x080000c0
        mov     r0, #0xd2                @ PSR_IRQ | PSR_I_BIT (IRQ mode, IRQs off)
        msr     CPSR_fc, r0
        ldr     sp, _start_irq_stack     @ IRQ-mode SP <- 0x03007FA0
        mov     r0, #0x1f                @ PSR_SYS
        msr     CPSR_fc, r0
        ldr     sp, _start_svc_stack     @ system-mode SP <- 0x03007F00
        ldr     r1, [pc, #0x14c]         @ -> word at 0x0800022C = 0x03007FFC (BIOS IRQ vector slot)
        add     r0, pc, #72              @ -> IntrMain at 0x0800012C
        str     r0, [r1]                 @ install IntrMain as IRQ handler
        ldr     r1, [pc, #0x144]         @ -> word at 0x08000230 = 0x080002A5 (thumb ptr to AgbMain)
        mov     lr, pc
        bx      r1                       @ call AgbMain
        b       _start                   @ AgbMain shouldn't return; loop forever if it does
_start_svc_stack:
        .word   0x03007F00
_start_irq_stack:
        .word   0x03007FA0
        arm_func_end _start
