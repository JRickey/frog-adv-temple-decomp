@ Auto-updated after peel of wave_effect.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027d18, 0x0802a2f0)  (0x25d8 bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027d18
        .type   text_08027d18, %object
text_08027d18:
        .incbin "frog_us_baserom.gba", 0x00027d18, 0x000025d8
        .size   text_08027d18, . - text_08027d18
