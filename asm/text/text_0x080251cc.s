@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080251cc, 0x0802a2f0)  (remaining after sub_080251A8 peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_080251cc
        .type   text_080251cc, %object
text_080251cc:
        .incbin "frog_us_baserom.gba", 0x0251cc, 0x5124
        .size   text_080251cc, . - text_080251cc
