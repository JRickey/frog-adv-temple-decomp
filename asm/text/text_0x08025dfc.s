@ Auto-emitted by peel at 0x08025dd0.
@ Shrunk for sub_08025DD0 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025dfc, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025dfc
        .type   text_08025dfc, %object
text_08025dfc:
        .incbin "frog_us_baserom.gba", 0x0025dfc, 0x0044f4
        .size   text_08025dfc, . - text_08025dfc
