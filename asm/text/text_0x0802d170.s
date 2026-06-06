@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d170, 0x0802d548)  (0x3d8 bytes)
@
@ Pre-peel chunk before sub_0802D548.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d170
        .type   text_0802d170, %object
text_0802d170:
        .incbin "frog_us_baserom.gba", 0x0002d170, 0x000003d8
        .size   text_0802d170, . - text_0802d170
