@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08003c9c, 0x08003ca8)  (0xc bytes)
@
@ Post-peel chunk after sub_08003C38.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08003c9c
        .type   text_08003c9c, %object
text_08003c9c:
        .incbin "frog_us_baserom.gba", 0x00003c9c, 0x0000000c
        .size   text_08003c9c, . - text_08003c9c
