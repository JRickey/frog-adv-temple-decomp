@ Auto-created during peel of sub_080276FC.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080276f4, 0x080276fc)  (0x8 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080276f4
        .type   text_080276f4, %object
text_080276f4:
        .incbin "frog_us_baserom.gba", 0x000276f4, 0x00000008
        .size   text_080276f4, . - text_080276f4
