@ Auto-created during peel of sub_080276B8.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080276f4, 0x0802a2f0)  (0x2bfc bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080276f4
        .type   text_080276f4, %object
text_080276f4:
        .incbin "frog_us_baserom.gba", 0x000276f4, 0x00002bfc
        .size   text_080276f4, . - text_080276f4
