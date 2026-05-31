@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080229cc, 0x0802a394)  (0x79c8 bytes)
@
@ Pre-peel chunk before sub_0802A394.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080229cc
        .type   text_080229cc, %object
text_080229cc:
        .incbin "frog_us_baserom.gba", 0x000229cc, 0x000079c8
        .size   text_080229cc, . - text_080229cc
