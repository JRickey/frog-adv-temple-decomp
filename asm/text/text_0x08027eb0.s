@ Auto-updated after peel of sub_08027E64.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027eb0, 0x0802a2f0)  (0x2440 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027eb0
        .type   text_08027eb0, %object
text_08027eb0:
        .incbin "frog_us_baserom.gba", 0x00027eb0, 0x00002440
        .size   text_08027eb0, . - text_08027eb0
