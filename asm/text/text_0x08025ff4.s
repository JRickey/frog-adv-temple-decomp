@ Auto-emitted by peel at 0x08025f70.
@ Shrunk for sub_08025FBC peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025ff4, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025ff4
        .type   text_08025ff4, %object
text_08025ff4:
        .incbin "frog_us_baserom.gba", 0x025ff4, 0x42fc
        .size   text_08025ff4, . - text_08025ff4
