@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024024, 0x0802a2f0)  (0x62cc bytes)
@
@ Post-peel chunk after sub_08023FF8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024024
        .type   text_08024024, %object
text_08024024:
        .incbin "frog_us_baserom.gba", 0x00024024, 0x000062cc
        .size   text_08024024, . - text_08024024
