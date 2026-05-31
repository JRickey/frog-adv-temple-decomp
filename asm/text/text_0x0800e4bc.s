@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800e4bc, 0x0800e600)  (0x144 bytes)
@
@ Post-peel chunk after sub_0800E174.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800e4bc
        .type   text_0800e4bc, %object
text_0800e4bc:
        .incbin "frog_us_baserom.gba", 0x0000e4bc, 0x00000144
        .size   text_0800e4bc, . - text_0800e4bc
