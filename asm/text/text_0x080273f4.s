@ Auto-emitted by peeler — raw bytes after sub_080273D0.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080273f4, 0x0802a2f0)  (0x2efc bytes)
@
@ Post-peel chunk after sub_080273D0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080273f4
        .type   text_080273f4, %object
text_080273f4:
        .incbin "frog_us_baserom.gba", 0x273f4, 0x2efc
        .size   text_080273f4, . - text_080273f4
