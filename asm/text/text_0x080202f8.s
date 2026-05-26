@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080202f8, 0x08020b30)  (0x838 bytes)
@
@ Post-peel chunk after sub_080202A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080202f8
        .type   text_080202f8, %object
text_080202f8:
        .incbin "frog_us_baserom.gba", 0x000202f8, 0x00000838
        .size   text_080202f8, . - text_080202f8
