@ Auto-generated after peel of sub_08027FD0.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027fd0, 0x08028008)  (0x38 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027fd0
        .type   text_08027fd0, %object
text_08027fd0:
        .incbin "frog_us_baserom.gba", 0x00027fd0, 0x00000038
        .size   text_08027fd0, . - text_08027fd0
