@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08000cb0, 0x08000cec)  (0x3c bytes)
@
@ Pre-peel chunk before sub_08000CEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08000cb0
        .type   text_08000cb0, %object
text_08000cb0:
        .incbin "frog_us_baserom.gba", 0x00000cb0, 0x0000003c
        .size   text_08000cb0, . - text_08000cb0
