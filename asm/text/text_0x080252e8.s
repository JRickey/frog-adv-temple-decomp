@ Auto-emitted by peeling sub_080252b0 — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080252e8, 0x0802a2f0)  (0x5008 bytes)
@
@ Post-peel chunk after sub_080252b0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080252e8
        .type   text_080252e8, %object
text_080252e8:
        .incbin "frog_us_baserom.gba", 0x000252e8, 0x00005008
        .size   text_080252e8, . - text_080252e8
