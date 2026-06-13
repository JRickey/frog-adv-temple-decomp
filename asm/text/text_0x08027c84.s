@ Auto-updated after peel of sub_08027AC4.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027c84, 0x0802a2f0)  (0x266c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027ac4
        .type   text_08027ac4, %object
text_08027ac4:
        .incbin "frog_us_baserom.gba", 0x00027c84, 0x0000266c
        .size   text_08027ac4, . - text_08027ac4
