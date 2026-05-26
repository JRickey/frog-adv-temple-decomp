@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08001484, 0x08001508)  (0x84 bytes)
@
@ Pre-peel chunk before sub_08001508.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08001484
        .type   text_08001484, %object
text_08001484:
        .incbin "frog_us_baserom.gba", 0x00001484, 0x00000084
        .size   text_08001484, . - text_08001484
