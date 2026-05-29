@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033da8, 0x08033e14)  (0x6c bytes)
@
@ Pre-peel chunk before sub_08033E14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033da8
        .type   text_08033da8, %object
text_08033da8:
        .incbin "frog_us_baserom.gba", 0x00033da8, 0x0000006c
        .size   text_08033da8, . - text_08033da8
