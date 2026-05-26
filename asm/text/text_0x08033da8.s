@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08033da8, 0x08033f5c)  (0x1b4 bytes)
@
@ Post-peel chunk after sub_08033D14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08033da8
        .type   text_08033da8, %object
text_08033da8:
        .incbin "frog_us_baserom.gba", 0x00033da8, 0x000001b4
        .size   text_08033da8, . - text_08033da8
