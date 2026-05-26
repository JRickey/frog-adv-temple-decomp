@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033948, 0x08033d14)  (0x3cc bytes)
@
@ Pre-peel chunk before sub_08033D14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033948
        .type   text_08033948, %object
text_08033948:
        .incbin "frog_us_baserom.gba", 0x00033948, 0x000003cc
        .size   text_08033948, . - text_08033948
