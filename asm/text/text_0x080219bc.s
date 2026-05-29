@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080219bc, 0x0802ab64)  (0x91a8 bytes)
@
@ Post-peel chunk after sub_08021838.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080219bc
        .type   text_080219bc, %object
text_080219bc:
        .incbin "frog_us_baserom.gba", 0x000219bc, 0x000091a8
        .size   text_080219bc, . - text_080219bc
