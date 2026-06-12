@ Auto-emitted by peeler — raw bytes after sub_08027138.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027310, 0x0802a2f0)  (0x2fe0 bytes)
@
@ Post-peel chunk after sub_08027138.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027310
        .type   text_08027310, %object
text_08027310:
        .incbin "frog_us_baserom.gba", 0x27310, 0x2fe0
        .size   text_08027310, . - text_08027310
