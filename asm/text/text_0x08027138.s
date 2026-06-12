@ Auto-emitted by peeler — raw bytes after sub_080270C0.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027138, 0x0802a2f0)  (0x31b8 bytes)
@
@ Post-peel chunk after sub_080270C0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027138
        .type   text_08027138, %object
text_08027138:
        .incbin "frog_us_baserom.gba", 0x27138, 0x31b8
        .size   text_08027138, . - text_08027138
