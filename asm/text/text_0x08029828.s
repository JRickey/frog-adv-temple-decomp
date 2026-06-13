@ Auto-updated after peel of sub_080297F0.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08029828, 0x0802a2f0)  (0xac8 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08029828
        .type   text_08029828, %object
text_08029828:
        .incbin "frog_us_baserom.gba", 0x00029828, 0x00000ac8
        .size   text_08029828, . - text_08029828
