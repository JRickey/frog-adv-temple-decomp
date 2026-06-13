@ Auto-created during peel of sub_08027744.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027770, 0x0802a2f0)  (0x2b80 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027770
        .type   text_08027770, %object
text_08027770:
        .incbin "frog_us_baserom.gba", 0x00027770, 0x00002b80
        .size   text_08027770, . - text_08027770
