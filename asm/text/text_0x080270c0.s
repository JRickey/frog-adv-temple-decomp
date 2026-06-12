@ Auto-emitted by peeler — raw bytes after sub_08027000.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080270c0, 0x0802a2f0)  (0x3230 bytes)
@
@ Post-peel chunk after sub_08027000.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080270c0
        .type   text_080270c0, %object
text_080270c0:
        .incbin "frog_us_baserom.gba", 0x270c0, 0x3230
        .size   text_080270c0, . - text_080270c0
