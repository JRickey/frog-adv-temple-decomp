@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801c6e4, 0x0801cec0)  (0x7dc bytes)
@
@ Pre-peel chunk before sub_0801CEC0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801c6e4
        .type   text_0801c6e4, %object
text_0801c6e4:
        .incbin "frog_us_baserom.gba", 0x0001c6e4, 0x000007dc
        .size   text_0801c6e4, . - text_0801c6e4
