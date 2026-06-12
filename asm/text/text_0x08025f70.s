@ Auto-emitted by peel at 0x08025f38.
@ Shrunk for sub_08025F38 peel.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025f70, 0x0802a2f0)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025f70
        .type   text_08025f70, %object
text_08025f70:
        .incbin "frog_us_baserom.gba", 0x0025f70, 0x4380
        .size   text_08025f70, . - text_08025f70
