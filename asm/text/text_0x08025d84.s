@ Auto-emitted by tools/peel.py — shrunk for sub_08025D60 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025d84, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025d84
        .type   text_08025d84, %object
text_08025d84:
        .incbin "frog_us_baserom.gba", 0x0025d84, 0x00456c
        .size   text_08025d84, . - text_08025d84
