@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801d0bc, 0x0801d150)  (0x94 bytes)
@
@ Pre-peel chunk before sub_0801D150.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801d0bc
        .type   text_0801d0bc, %object
text_0801d0bc:
        .incbin "frog_us_baserom.gba", 0x0001d0bc, 0x00000094
        .size   text_0801d0bc, . - text_0801d0bc
