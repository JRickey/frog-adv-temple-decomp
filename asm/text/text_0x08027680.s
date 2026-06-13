@ Auto-created during peel of sub_08027634.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027680, 0x0802a2f0)  (0x2c70 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027680
        .type   text_08027680, %object
text_08027680:
        .incbin "frog_us_baserom.gba", 0x00027680, 0x00002c70
        .size   text_08027680, . - text_08027680
