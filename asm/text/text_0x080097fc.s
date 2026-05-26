@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080097fc, 0x08009984)  (0x188 bytes)
@
@ Pre-peel chunk before sub_08009984.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080097fc
        .type   text_080097fc, %object
text_080097fc:
        .incbin "frog_us_baserom.gba", 0x000097fc, 0x00000188
        .size   text_080097fc, . - text_080097fc
