@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080014f0, 0x08001508)  (0x18 bytes)
@
@ Post-peel chunk after sub_080014E4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080014f0
        .type   text_080014f0, %object
text_080014f0:
        .incbin "frog_us_baserom.gba", 0x000014f0, 0x00000018
        .size   text_080014f0, . - text_080014f0
