@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020b50, 0x08020b60)  (0x10 bytes)
@
@ Pre-peel chunk before sub_08020B60.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020b50
        .type   text_08020b50, %object
text_08020b50:
        .incbin "frog_us_baserom.gba", 0x00020b50, 0x00000010
        .size   text_08020b50, . - text_08020b50
