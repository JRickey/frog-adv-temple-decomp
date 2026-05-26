@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08010740, 0x08016404)  (0x5cc4 bytes)
@
@ Pre-peel chunk before sub_08016404.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08010740
        .type   text_08010740, %object
text_08010740:
        .incbin "frog_us_baserom.gba", 0x00010740, 0x00005cc4
        .size   text_08010740, . - text_08010740
