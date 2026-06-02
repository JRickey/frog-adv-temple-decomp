@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801b0ac, 0x0801b374)  (0x2c8 bytes)
@
@ Post-peel chunk after sub_0801ADA8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801b0ac
        .type   text_0801b0ac, %object
text_0801b0ac:
        .incbin "frog_us_baserom.gba", 0x0001b0ac, 0x000002c8
        .size   text_0801b0ac, . - text_0801b0ac
