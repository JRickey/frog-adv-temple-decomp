@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024b68, 0x0802a2f0)  (remaining after sub_08024B3C peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08024B68
        .type   text_08024B68, %object
text_08024B68:
        .incbin "frog_us_baserom.gba", 0x024b68, 0x5788
        .size   text_08024B68, . - text_08024B68
