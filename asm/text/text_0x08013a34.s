@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013a34, 0x08013c60)  (0x22c bytes)
@
@ Post-peel chunk after sub_080139F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013a34
        .type   text_08013a34, %object
text_08013a34:
        .incbin "frog_us_baserom.gba", 0x00013a34, 0x0000022c
        .size   text_08013a34, . - text_08013a34
