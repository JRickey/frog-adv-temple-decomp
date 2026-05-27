@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800e85c, 0x0800ee34)  (0x5d8 bytes)
@
@ Pre-peel chunk before sub_0800EE34.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800e85c
        .type   text_0800e85c, %object
text_0800e85c:
        .incbin "frog_us_baserom.gba", 0x0000e85c, 0x000005d8
        .size   text_0800e85c, . - text_0800e85c
