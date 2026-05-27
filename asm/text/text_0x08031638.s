@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08031638, 0x08032094)  (0xa5c bytes)
@
@ Pre-peel chunk before sub_08032094.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08031638
        .type   text_08031638, %object
text_08031638:
        .incbin "frog_us_baserom.gba", 0x00031638, 0x00000a5c
        .size   text_08031638, . - text_08031638
