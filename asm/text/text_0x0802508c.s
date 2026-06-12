@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802508c, 0x0802a2f0)  (remaining after sub_08024FD0 peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_0802508C
        .type   text_0802508C, %object
text_0802508C:
        .incbin "frog_us_baserom.gba", 0x02508c, 0x5264
        .size   text_0802508C, . - text_0802508C
