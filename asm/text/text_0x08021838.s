@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021838, 0x0802ab64)  (0x932c bytes)
@
@ Post-peel chunk after sub_080217D4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021838
        .type   text_08021838, %object
text_08021838:
        .incbin "frog_us_baserom.gba", 0x00021838, 0x0000932c
        .size   text_08021838, . - text_08021838
