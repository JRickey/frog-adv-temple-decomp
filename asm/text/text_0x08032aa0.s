@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08032aa0, 0x08032b18)  (0x78 bytes)
@
@ Pre-peel chunk before sub_08032B18.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08032aa0
        .type   text_08032aa0, %object
text_08032aa0:
        .incbin "frog_us_baserom.gba", 0x00032aa0, 0x00000078
        .size   text_08032aa0, . - text_08032aa0
