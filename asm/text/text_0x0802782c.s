@ Auto-updated after peel of sub_080277F4.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802782c, 0x0802a2f0)  (0x2ac4 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802782c
        .type   text_0802782c, %object
text_0802782c:
        .incbin "frog_us_baserom.gba", 0x0002782c, 0x00002ac4
        .size   text_0802782c, . - text_0802782c
