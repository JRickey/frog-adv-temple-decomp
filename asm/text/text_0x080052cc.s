@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080052cc, 0x080054a8)  (0x1dc bytes)
@
@ Pre-peel chunk before sub_080054A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080052cc
        .type   text_080052cc, %object
text_080052cc:
        .incbin "frog_us_baserom.gba", 0x000052cc, 0x000001dc
        .size   text_080052cc, . - text_080052cc
