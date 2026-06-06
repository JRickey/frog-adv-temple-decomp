@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08035d84, 0x08035d8c)  (8 bytes)
@
@ One 8-byte Thumb-to-ARM interwork veneer, mirrored from
@ IntrEnable_Thunk's pattern:
@
@   0x08035d84  bx pc; nop; b 0x08000240   (sub_08000240, ARM)
@
@ The next two veneers were promoted to their own thumb_func_start
@ slices so Thumb C callers can BL them by name:
@   0x08035d8c  bx pc; nop; b 0x08032e38   (sound-IRQ disable;
@                                           asm/disasm_0x08035d8c.s)
@   0x08035d94  bx pc; nop; b 0x08032e1c   (sound-IRQ enable;
@                                           asm/disasm_0x08035d94.s)
@
@ Kept as raw bytes for now; promote the remaining one to
@ thumb_func_start slice once a Thumb caller of it lands in C.
@
@ Originally [0x08035d84, 0x08040000); shrunk when sIrqHandlerTable
@ was extracted at 0x08035d9c into src/data/irq_handler_table.c. The
@ remainder of the original blob lives in asm/text/text_0x08035dd0.s.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08035d84
        .type   text_08035d84, %object
text_08035d84:
        .incbin "frog_us_baserom.gba", 0x00035d84, 0x00000008
        .size   text_08035d84, . - text_08035d84
