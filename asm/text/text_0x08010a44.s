@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08010a44, 0x0801129c)  (0x858 bytes)
@
@ Pre-peel chunk before sub_0801129C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08010a44
        .type   text_08010a44, %object
text_08010a44:
        .incbin "frog_us_baserom.gba", 0x00010a44, 0x00000858
        .size   text_08010a44, . - text_08010a44
