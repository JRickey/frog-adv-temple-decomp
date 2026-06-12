@ Auto-emitted by peeling sub_08025264 — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080252b0, 0x0802a2f0)  (0x5040 bytes)
@
@ Post-peel chunk after sub_08025264.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080252b0
        .type   text_080252b0, %object
text_080252b0:
        .incbin "frog_us_baserom.gba", 0x000252b0, 0x00005040
        .size   text_080252b0, . - text_080252b0
