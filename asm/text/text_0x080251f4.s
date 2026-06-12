@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080251f4, 0x0802a2f0)  (remaining after sub_080251CC peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_080251f4
        .type   text_080251f4, %object
text_080251f4:
        .incbin "frog_us_baserom.gba", 0x0251f4, 0x50fc
        .size   text_080251f4, . - text_080251f4
