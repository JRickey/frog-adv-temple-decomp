@ Auto-emitted by tools/peel.py — shrunk for sub_08025D14 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025d38, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025d38
        .type   text_08025d38, %object
text_08025d38:
        .incbin "frog_us_baserom.gba", 0x0025d38, 0x004fb8
        .size   text_08025d38, . - text_08025d38
