@ Auto-generated after peel of sub_08028008.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08028084, 0x0802a2f0)  (0x226c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08028084
        .type   text_08028084, %object
text_08028084:
        .incbin "frog_us_baserom.gba", 0x00028084, 0x0000226c
        .size   text_08028084, . - text_08028084
