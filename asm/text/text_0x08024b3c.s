@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024b3c, 0x0802a2f0)  (remaining after sub_08024AE8 peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08024B3C
        .type   text_08024B3C, %object
text_08024B3C:
        .incbin "frog_us_baserom.gba", 0x024b3c, 0x57b4
        .size   text_08024B3C, . - text_08024B3C
