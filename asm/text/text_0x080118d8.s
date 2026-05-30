@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080118d8, 0x08012180)  (0x8a8 bytes)
@
@ Pre-peel chunk before sub_08012180.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080118d8
        .type   text_080118d8, %object
text_080118d8:
        .incbin "frog_us_baserom.gba", 0x000118d8, 0x000008a8
        .size   text_080118d8, . - text_080118d8
