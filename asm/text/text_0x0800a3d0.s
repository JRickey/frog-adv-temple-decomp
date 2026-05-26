@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a3d0, 0x0800a4d0)  (0x100 bytes)
@
@ Pre-peel chunk before sub_0800A4D0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a3d0
        .type   text_0800a3d0, %object
text_0800a3d0:
        .incbin "frog_us_baserom.gba", 0x0000a3d0, 0x00000100
        .size   text_0800a3d0, . - text_0800a3d0
