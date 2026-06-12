@ Auto-emitted by peel at 0x08025dfc.
@ Shrunk for sub_08025DFC peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025e60, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025e60
        .type   text_08025e60, %object
text_08025e60:
        .incbin "frog_us_baserom.gba", 0x0025e60, 0x004490
        .size   text_08025e60, . - text_08025e60
