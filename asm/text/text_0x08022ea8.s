@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022ea8, 0x0802a394)  (0x74ec bytes)
@
@ Post-peel chunk after sub_08022DDC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022ea8
        .type   text_08022ea8, %object
text_08022ea8:
        .incbin "frog_us_baserom.gba", 0x00022ea8, 0x000074ec
        .size   text_08022ea8, . - text_08022ea8
