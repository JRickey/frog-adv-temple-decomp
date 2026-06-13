@ Auto-created during peel of sub_08027770.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027794, 0x0802a2f0)  (0x2b5c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027794
        .type   text_08027794, %object
text_08027794:
        .incbin "frog_us_baserom.gba", 0x00027794, 0x00002b5c
        .size   text_08027794, . - text_08027794
