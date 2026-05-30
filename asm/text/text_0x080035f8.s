@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080035f8, 0x08003668)  (0x70 bytes)
@
@ Post-peel chunk after sub_080035D0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080035f8
        .type   text_080035f8, %object
text_080035f8:
        .incbin "frog_us_baserom.gba", 0x000035f8, 0x00000070
        .size   text_080035f8, . - text_080035f8
