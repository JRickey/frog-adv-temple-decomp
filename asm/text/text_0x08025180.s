@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025180, 0x0802a2f0)  (remaining after sub_0802508C peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08025180
        .type   text_08025180, %object
text_08025180:
        .incbin "frog_us_baserom.gba", 0x025180, 0x5170
        .size   text_08025180, . - text_08025180
