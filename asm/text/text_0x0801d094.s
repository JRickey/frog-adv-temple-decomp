@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801d094, 0x0801e28c)  (0x11f8 bytes)
@
@ Post-peel chunk after sub_0801D048.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801d094
        .type   text_0801d094, %object
text_0801d094:
        .incbin "frog_us_baserom.gba", 0x0001d094, 0x000011f8
        .size   text_0801d094, . - text_0801d094
