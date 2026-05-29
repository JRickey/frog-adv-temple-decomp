@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080014b8, 0x08001508)  (0x50 bytes)
@
@ Post-peel chunk after sub_08001484.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080014b8
        .type   text_080014b8, %object
text_080014b8:
        .incbin "frog_us_baserom.gba", 0x000014b8, 0x00000050
        .size   text_080014b8, . - text_080014b8
