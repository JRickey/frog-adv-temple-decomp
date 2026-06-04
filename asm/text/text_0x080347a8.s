@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080347a8, 0x08034898)  (0xf0 bytes)
@
@ Pre-peel chunk before sub_08034898.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080347a8
        .type   text_080347a8, %object
text_080347a8:
        .incbin "frog_us_baserom.gba", 0x000347a8, 0x000000f0
        .size   text_080347a8, . - text_080347a8
