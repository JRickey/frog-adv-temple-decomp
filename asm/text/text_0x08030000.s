@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08030000, 0x08033910)  (0x3910 bytes)
@
@ Pre-peel chunk before sub_08033910.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08030000
        .type   text_08030000, %object
text_08030000:
        .incbin "frog_us_baserom.gba", 0x00030000, 0x00003910
        .size   text_08030000, . - text_08030000
