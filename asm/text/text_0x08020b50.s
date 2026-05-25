@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020b50, 0x0802d558)  (0xca08 bytes)
@
@ Pre-peel chunk before sub_0802D558.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020b50
        .type   text_08020b50, %object
text_08020b50:
        .incbin "frog_us_baserom.gba", 0x00020b50, 0x0000ca08
        .size   text_08020b50, . - text_08020b50
