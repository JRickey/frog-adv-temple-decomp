@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a3d0, 0x0800de80)  (0x3ab0 bytes)
@
@ Post-peel chunk after sub_0800A328.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a3d0
        .type   text_0800a3d0, %object
text_0800a3d0:
        .incbin "frog_us_baserom.gba", 0x0000a3d0, 0x00003ab0
        .size   text_0800a3d0, . - text_0800a3d0
