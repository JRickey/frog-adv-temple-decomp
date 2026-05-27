@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08032148, 0x080325b0)  (0x468 bytes)
@
@ Post-peel chunk after sub_08032094.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08032148
        .type   text_08032148, %object
text_08032148:
        .incbin "frog_us_baserom.gba", 0x00032148, 0x00000468
        .size   text_08032148, . - text_08032148
