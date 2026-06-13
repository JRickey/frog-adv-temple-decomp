@ Auto-created during peel of sub_080275FC.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027634, 0x0802a2f0)  (0x2cbc bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027634
        .type   text_08027634, %object
text_08027634:
        .incbin "frog_us_baserom.gba", 0x00027634, 0x00002cbc
        .size   text_08027634, . - text_08027634
