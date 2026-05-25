@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802ea2c, 0x0802ea80)  (0x54 bytes)
@
@ Pre-peel chunk before sub_0802EA80.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802ea2c
        .type   text_0802ea2c, %object
text_0802ea2c:
        .incbin "frog_us_baserom.gba", 0x0002ea2c, 0x00000054
        .size   text_0802ea2c, . - text_0802ea2c
