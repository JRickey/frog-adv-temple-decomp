@ Auto-updated after peel of sub_08027F40.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027ee8, 0x08027f40)  (0x58 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027ee8
        .type   text_08027ee8, %object
text_08027ee8:
        .incbin "frog_us_baserom.gba", 0x00027ee8, 0x00000058
        .size   text_08027ee8, . - text_08027ee8
