@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024ae8, 0x0802a2f0)  (remaining after sub_08024AC4 peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08024AE8
        .type   text_08024AE8, %object
text_08024AE8:
        .incbin "frog_us_baserom.gba", 0x024ae8, 0x5808
        .size   text_08024AE8, . - text_08024AE8
