@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801b71c, 0x0801b9e4)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801b71c
        .type   text_0801b71c, %object
text_0801b71c:
        .incbin "frog_us_baserom.gba", 0x0001b71c, 0x000002c8
        .size   text_0801b71c, . - text_0801b71c
