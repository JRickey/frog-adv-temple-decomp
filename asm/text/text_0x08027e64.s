@ Auto-updated after peel of sub_08027E3C.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027e64, 0x0802a2f0)  (0x248c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027e64
        .type   text_08027e64, %object
text_08027e64:
        .incbin "frog_us_baserom.gba", 0x00027e64, 0x0000248c
        .size   text_08027e64, . - text_08027e64
