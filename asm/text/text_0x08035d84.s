@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08035d84, 0x08035d94)  (0x10 bytes)
@
@ Two 8-byte Thumb-to-ARM interwork veneers, mirrored from
@ sub_08035D7C's pattern:
@
@   0x08035d84  bx pc; nop; b 0x08000240   (sub_08000240, ARM)
@   0x08035d8c  bx pc; nop; b 0x08032e38   (sound-IRQ disable, ARM)
@
@ The third veneer at 0x08035d94 (sound-IRQ enable; bx pc; nop;
@ b 0x08032e1c) was promoted to its own thumb_func_start slice in
@ asm/disasm_0x08035d94.s so sub_0802E3F8's C decomp can BL it by
@ name.
@
@ Kept as raw bytes for now; promote the remaining two to
@ thumb_func_start slices once a Thumb caller of either lands in C.
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
        .incbin "frog_us_baserom.gba", 0x00035d84, 0x00000010
        .size   text_08035d84, . - text_08035d84
