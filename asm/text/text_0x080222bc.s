@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080222bc, 0x0802ab64)  (0x88a8 bytes)
@
@ Post-peel chunk after sub_080221FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080222bc
        .type   text_080222bc, %object
text_080222bc:
        .incbin "frog_us_baserom.gba", 0x000222bc, 0x000088a8
        .size   text_080222bc, . - text_080222bc
