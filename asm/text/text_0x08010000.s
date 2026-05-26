@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08010000, 0x08010694)  (0x694 bytes)
@
@ Pre-peel chunk before sub_08010694.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08010000
        .type   text_08010000, %object
text_08010000:
        .incbin "frog_us_baserom.gba", 0x00010000, 0x00000694
        .size   text_08010000, . - text_08010000
