@ Auto-created during peel of sub_08027794.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080277f4, 0x0802a2f0)  (0x2afc bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080277f4
        .type   text_080277f4, %object
text_080277f4:
        .incbin "frog_us_baserom.gba", 0x000277f4, 0x00002afc
        .size   text_080277f4, . - text_080277f4
