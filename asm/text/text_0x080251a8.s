@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080251a8, 0x0802a2f0)  (remaining after sub_08025180 peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_080251a8
        .type   text_080251a8, %object
text_080251a8:
        .incbin "frog_us_baserom.gba", 0x0251a8, 0x5148
        .size   text_080251a8, . - text_080251a8
