@ Auto-emitted by peeler — raw bytes after sub_08027384.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080273a8, 0x0802a2f0)  (0x2f48 bytes)
@
@ Post-peel chunk after sub_08027384.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080273a8
        .type   text_080273a8, %object
text_080273a8:
        .incbin "frog_us_baserom.gba", 0x273a8, 0x2f48
        .size   text_080273a8, . - text_080273a8
