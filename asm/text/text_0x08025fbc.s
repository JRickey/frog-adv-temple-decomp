@ Auto-emitted by peel at 0x08025f70.
@ Shrunk for sub_08025F70 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025fbc, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025fbc
        .type   text_08025fbc, %object
text_08025fbc:
        .incbin "frog_us_baserom.gba", 0x025fbc, 0x4334
        .size   text_08025fbc, . - text_08025fbc
