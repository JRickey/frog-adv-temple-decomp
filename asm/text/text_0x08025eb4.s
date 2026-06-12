@ Auto-emitted by peel at 0x08025e60.
@ Shrunk for sub_08025E60 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025eb4, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025eb4
        .type   text_08025eb4, %object
text_08025eb4:
        .incbin "frog_us_baserom.gba", 0x0025eb4, 0x00443c
        .size   text_08025eb4, . - text_08025eb4
