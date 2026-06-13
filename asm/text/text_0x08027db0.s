@ Auto-emitted by peeler — raw bytes after sub_08027D8C.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027db0, 0x0802a2f0)  (0x2540 bytes)
@
@ Post-peel chunk after sub_08027D8C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027db0
        .type   text_08027db0, %object
text_08027db0:
        .incbin "frog_us_baserom.gba", 0x27db0, 0x2540
        .size   text_08027db0, . - text_08027db0
