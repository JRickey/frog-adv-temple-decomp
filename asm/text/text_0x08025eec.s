@ Auto-emitted by peel at 0x08025e60.
@ Shrunk for sub_08025EB4 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025eec, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025eb4
        .type   text_08025eb4, %object
text_08025eec:
        .incbin "frog_us_baserom.gba", 0x0025eec, 0x004404
        .size   text_08025eec, . - text_08025eec
