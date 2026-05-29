@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080027f0, 0x08002844)  (0x54 bytes)
@
@ Post-peel chunk after sub_080027A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080027f0
        .type   text_080027f0, %object
text_080027f0:
        .incbin "frog_us_baserom.gba", 0x000027f0, 0x00000054
        .size   text_080027f0, . - text_080027f0
