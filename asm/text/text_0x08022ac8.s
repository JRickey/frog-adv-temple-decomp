@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022ac8, 0x0802a394)  (0x78cc bytes)
@
@ Post-peel chunk after sub_08022A9C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022ac8
        .type   text_08022ac8, %object
text_08022ac8:
        .incbin "frog_us_baserom.gba", 0x00022ac8, 0x000078cc
        .size   text_08022ac8, . - text_08022ac8
