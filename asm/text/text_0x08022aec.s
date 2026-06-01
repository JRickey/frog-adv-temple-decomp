@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022aec, 0x0802a394)  (0x78a8 bytes)
@
@ Post-peel chunk after sub_08022AC8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022aec
        .type   text_08022aec, %object
text_08022aec:
        .incbin "frog_us_baserom.gba", 0x00022aec, 0x000078a8
        .size   text_08022aec, . - text_08022aec
