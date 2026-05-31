@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800dab8, 0x0800dc50)  (0x198 bytes)
@
@ Post-peel chunk after sub_0800DA10.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800dab8
        .type   text_0800dab8, %object
text_0800dab8:
        .incbin "frog_us_baserom.gba", 0x0000dab8, 0x00000198
        .size   text_0800dab8, . - text_0800dab8
