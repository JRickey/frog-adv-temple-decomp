@ Auto-emitted by peeler — raw bytes after sub_08027D64.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027d8c, 0x0802a2f0)  (0x2564 bytes)
@
@ Post-peel chunk after sub_08027D64.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027d8c
        .type   text_08027d8c, %object
text_08027d8c:
        .incbin "frog_us_baserom.gba", 0x27d8c, 0x2564
        .size   text_08027d8c, . - text_08027d8c
