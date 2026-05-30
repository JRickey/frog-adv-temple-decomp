@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080045e0, 0x080045ec)  (0xc bytes)
@
@ Post-peel chunk after sub_08004588.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080045e0
        .type   text_080045e0, %object
text_080045e0:
        .incbin "frog_us_baserom.gba", 0x000045e0, 0x0000000c
        .size   text_080045e0, . - text_080045e0
