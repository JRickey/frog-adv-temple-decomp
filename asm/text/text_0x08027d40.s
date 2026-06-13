@ Auto-updated after peel of sub_08027D18.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027d40, 0x0802a2f0)  (0x25b0 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027d18
        .type   text_08027d18, %object
text_08027d18:
        .incbin "frog_us_baserom.gba", 0x00027d40, 0x000025b0
        .size   text_08027d18, . - text_08027d18
