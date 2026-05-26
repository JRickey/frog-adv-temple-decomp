@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020000, 0x080201a8)  (0x1a8 bytes)
@
@ Pre-peel chunk before sub_080201A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020000
        .type   text_08020000, %object
text_08020000:
        .incbin "frog_us_baserom.gba", 0x00020000, 0x000001a8
        .size   text_08020000, . - text_08020000
