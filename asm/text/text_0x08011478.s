@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011478, 0x08011518)  (0xa0 bytes)
@
@ Pre-peel chunk before sub_08011518.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011478
        .type   text_08011478, %object
text_08011478:
        .incbin "frog_us_baserom.gba", 0x00011478, 0x000000a0
        .size   text_08011478, . - text_08011478
