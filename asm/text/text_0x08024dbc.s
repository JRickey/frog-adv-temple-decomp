@ Auto-emitted by peel.py — remaining bytes after function extraction.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024dbc, 0x0802a2f0)  (remaining after sub_08024CD0 peeled)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .balign 1
        .global text_08024DBC
        .type   text_08024DBC, %object
text_08024DBC:
        .incbin "frog_us_baserom.gba", 0x024dbc, 0x5534
        .size   text_08024DBC, . - text_08024DBC
