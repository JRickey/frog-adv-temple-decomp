@ Auto-emitted by peeler — raw bytes after sub_0802735C.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027384, 0x0802a2f0)  (0x2f6c bytes)
@
@ Post-peel chunk after sub_0802735C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027384
        .type   text_08027384, %object
text_08027384:
        .incbin "frog_us_baserom.gba", 0x27384, 0x2f6c
        .size   text_08027384, . - text_08027384
