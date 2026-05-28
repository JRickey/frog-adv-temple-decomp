@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08010740, 0x08012b38)  (0x23f8 bytes)
@
@ Pre-peel chunk before sub_08012B38.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08010740
        .type   text_08010740, %object
text_08010740:
        .incbin "frog_us_baserom.gba", 0x00010740, 0x000023f8
        .size   text_08010740, . - text_08010740
