@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801cfa0, 0x0801d048)  (0xa8 bytes)
@
@ Post-peel chunk after sub_0801CF18.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801cfa0
        .type   text_0801cfa0, %object
text_0801cfa0:
        .incbin "frog_us_baserom.gba", 0x0001cfa0, 0x000000a8
        .size   text_0801cfa0, . - text_0801cfa0
