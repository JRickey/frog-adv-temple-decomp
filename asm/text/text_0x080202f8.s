@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080202f8, 0x080204a4)  (0x1ac bytes)
@
@ Pre-peel chunk before sub_080204A4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080202f8
        .type   text_080202f8, %object
text_080202f8:
        .incbin "frog_us_baserom.gba", 0x000202f8, 0x000001ac
        .size   text_080202f8, . - text_080202f8
