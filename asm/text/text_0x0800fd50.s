@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800fd50, 0x08010000)  (0x2b0 bytes)
@
@ Post-peel chunk after sub_0800FCC8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800fd50
        .type   text_0800fd50, %object
text_0800fd50:
        .incbin "frog_us_baserom.gba", 0x0000fd50, 0x000002b0
        .size   text_0800fd50, . - text_0800fd50
