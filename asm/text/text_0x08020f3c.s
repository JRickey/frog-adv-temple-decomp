@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020f3c, 0x0802ab64)  (0x9c28 bytes)
@
@ Pre-peel chunk before sub_0802AB64.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020f3c
        .type   text_08020f3c, %object
text_08020f3c:
        .incbin "frog_us_baserom.gba", 0x00020f3c, 0x00009c28
        .size   text_08020f3c, . - text_08020f3c
