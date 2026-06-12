@ Auto-emitted by tools/peel.py — shrunk for sub_08025D38 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025d60, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025d60
        .type   text_08025d60, %object
text_08025d60:
        .incbin "frog_us_baserom.gba", 0x0025d60, 0x004590
        .size   text_08025d60, . - text_08025d60
