@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801089c, 0x08010958)  (0xbc bytes)
@
@ Post-peel chunk after sub_08010740.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801089c
        .type   text_0801089c, %object
text_0801089c:
        .incbin "frog_us_baserom.gba", 0x0001089c, 0x000000bc
        .size   text_0801089c, . - text_0801089c
