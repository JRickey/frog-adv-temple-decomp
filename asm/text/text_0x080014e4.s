@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080014e4, 0x08001508)  (0x24 bytes)
@
@ Post-peel chunk after sub_080014B8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080014e4
        .type   text_080014e4, %object
text_080014e4:
        .incbin "frog_us_baserom.gba", 0x000014e4, 0x00000024
        .size   text_080014e4, . - text_080014e4
