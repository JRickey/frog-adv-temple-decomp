@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801ba34, 0x0801bb54)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801ba34
        .type   text_0801ba34, %object
text_0801ba34:
        .incbin "frog_us_baserom.gba", 0x0001ba34, 0x00000120
        .size   text_0801ba34, . - text_0801ba34
