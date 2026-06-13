@ Auto-updated after peel of sub_08027EB0.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027ee8, 0x0802a2f0)  (0x2408 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027ee8
        .type   text_08027ee8, %object
text_08027ee8:
        .incbin "frog_us_baserom.gba", 0x00027ee8, 0x00002408
        .size   text_08027ee8, . - text_08027ee8
