@ Auto-generated after peel of sub_08027F40.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027f78, 0x0802a2f0)  (0x2378 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027f78
        .type   text_08027f78, %object
text_08027f78:
        .incbin "frog_us_baserom.gba", 0x00027f78, 0x00002378
        .size   text_08027f78, . - text_08027f78
