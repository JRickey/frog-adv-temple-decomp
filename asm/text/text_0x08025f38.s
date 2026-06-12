@ Auto-emitted by peel at 0x08025eec.
@ Shrunk for sub_08025EEC peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025f38, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025f38
        .type   text_08025f38, %object
text_08025f38:
        .incbin "frog_us_baserom.gba", 0x0025f38, 0x43b8
        .size   text_08025f38, . - text_08025f38
