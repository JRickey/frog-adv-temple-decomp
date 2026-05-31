@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802aae8, 0x0802ab14)  (0x2c bytes)
@
@ Pre-peel chunk before sub_0802AB14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802aae8
        .type   text_0802aae8, %object
text_0802aae8:
        .incbin "frog_us_baserom.gba", 0x0002aae8, 0x0000002c
        .size   text_0802aae8, . - text_0802aae8
