@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08035dd0, 0x08040000)  (0xa230 bytes)
@
@ Tail half of the original [0x08035d84, 0x08040000) blob. Carved out
@ when sIrqHandlerTable was extracted at 0x08035d9c into
@ src/data/irq_handler_table.c.
@
@ Mostly sparse / zero-padded data structures (probably sound song or
@ engine constants); not yet investigated.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08035dd0
        .type   text_08035dd0, %object
text_08035dd0:
        .incbin "frog_us_baserom.gba", 0x00035dd0, 0x0000a230
        .size   text_08035dd0, . - text_08035dd0
