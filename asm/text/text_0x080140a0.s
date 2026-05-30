@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080140a0, 0x08016360)  (0x22c0 bytes)
@
@ Post-peel chunk after sub_08014078.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080140a0
        .type   text_080140a0, %object
text_080140a0:
        .incbin "frog_us_baserom.gba", 0x000140a0, 0x000022c0
        .size   text_080140a0, . - text_080140a0
