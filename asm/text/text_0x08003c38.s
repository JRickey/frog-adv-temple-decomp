@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08003c38, 0x08003ca8)  (0x70 bytes)
@
@ Post-peel chunk after sub_08003BFC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08003c38
        .type   text_08003c38, %object
text_08003c38:
        .incbin "frog_us_baserom.gba", 0x00003c38, 0x00000070
        .size   text_08003c38, . - text_08003c38
