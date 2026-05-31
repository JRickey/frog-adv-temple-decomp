@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080185c0, 0x0801932c)  (0xd6c bytes)
@
@ Post-peel chunk after sub_080184DC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080185c0
        .type   text_080185c0, %object
text_080185c0:
        .incbin "frog_us_baserom.gba", 0x000185c0, 0x00000d6c
        .size   text_080185c0, . - text_080185c0
