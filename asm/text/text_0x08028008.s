@ Auto-generated after peel of sub_08027FD0.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08028008, 0x0802a2f0)  (0x22e8 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08028008
        .type   text_08028008, %object
text_08028008:
        .incbin "frog_us_baserom.gba", 0x00028008, 0x000022e8
        .size   text_08028008, . - text_08028008
