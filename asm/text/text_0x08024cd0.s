@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024cd0, 0x0802a2f0)  (remaining after sub_08024B68 peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08024CD0
        .type   text_08024CD0, %object
text_08024CD0:
        .incbin "frog_us_baserom.gba", 0x024cd0, 0x5620
        .size   text_08024CD0, . - text_08024CD0
