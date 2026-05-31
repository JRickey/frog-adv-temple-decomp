@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802abb0, 0x0802b9d4)  (0xe24 bytes)
@
@ Pre-peel chunk before sub_0802B9D4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802abb0
        .type   text_0802abb0, %object
text_0802abb0:
        .incbin "frog_us_baserom.gba", 0x0002abb0, 0x00000e24
        .size   text_0802abb0, . - text_0802abb0
