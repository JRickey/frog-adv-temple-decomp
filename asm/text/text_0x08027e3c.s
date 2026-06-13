@ Auto-updated after peel of sub_08027DFC.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027e3c, 0x0802a2f0)  (0x24b4 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027e3c
        .type   text_08027e3c, %object
text_08027e3c:
        .incbin "frog_us_baserom.gba", 0x00027e3c, 0x000024b4
        .size   text_08027e3c, . - text_08027e3c
