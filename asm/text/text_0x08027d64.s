@ Auto-updated after peel of sub_08027D40.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027d64, 0x0802a2f0)  (0x258c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027d40
        .type   text_08027d40, %object
text_08027d40:
        .incbin "frog_us_baserom.gba", 0x00027d64, 0x0000258c
        .size   text_08027d40, . - text_08027d40
