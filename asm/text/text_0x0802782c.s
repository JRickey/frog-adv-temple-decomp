@ Auto-updated after peel of sub_0802782C.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802782c, 0x080278dc)  (0xb0 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802782c
        .type   text_0802782c, %object
text_0802782c:
        .incbin "frog_us_baserom.gba", 0x0002782c, 0x000000b0
        .size   text_0802782c, . - text_0802782c
