@ Auto-created during peel of sub_08027680.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080276b8, 0x0802a2f0)  (0x2c38 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080276b8
        .type   text_080276b8, %object
text_080276b8:
        .incbin "frog_us_baserom.gba", 0x000276b8, 0x00002c38
        .size   text_080276b8, . - text_080276b8
