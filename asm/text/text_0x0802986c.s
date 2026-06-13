@ Auto-updated after peel of sub_08029828.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802986c, 0x0802a2f0)  (0xa84 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802986c
        .type   text_0802986c, %object
text_0802986c:
        .incbin "frog_us_baserom.gba", 0x0002986c, 0x00000a84
        .size   text_0802986c, . - text_0802986c
