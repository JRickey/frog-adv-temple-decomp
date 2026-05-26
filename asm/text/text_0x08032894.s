@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08032894, 0x08033910)  (0x107c bytes)
@
@ Post-peel chunk after sub_080325B0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08032894
        .type   text_08032894, %object
text_08032894:
        .incbin "frog_us_baserom.gba", 0x00032894, 0x0000107c
        .size   text_08032894, . - text_08032894
