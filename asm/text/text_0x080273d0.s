@ Auto-emitted by peeler — raw bytes after sub_080273A8.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080273d0, 0x0802a2f0)  (0x2f20 bytes)
@
@ Post-peel chunk after sub_080273A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080273d0
        .type   text_080273d0, %object
text_080273d0:
        .incbin "frog_us_baserom.gba", 0x273d0, 0x2f20
        .size   text_080273d0, . - text_080273d0
