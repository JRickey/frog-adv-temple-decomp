@ Auto-updated after peel of sub_08027DD8.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027dfc, 0x0802a2f0)  (0x24f4 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027dfc
        .type   text_08027dfc, %object
text_08027dfc:
        .incbin "frog_us_baserom.gba", 0x00027dfc, 0x000024f4
        .size   text_08027dfc, . - text_08027dfc
