@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08031638, 0x08033910)  (0x22d8 bytes)
@
@ Post-peel chunk after sub_080315D8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08031638
        .type   text_08031638, %object
text_08031638:
        .incbin "frog_us_baserom.gba", 0x00031638, 0x000022d8
        .size   text_08031638, . - text_08031638
