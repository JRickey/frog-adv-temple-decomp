@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080116b8, 0x0801185c)  (0x1a4 bytes)
@
@ Post-peel chunk after sub_080115F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080116b8
        .type   text_080116b8, %object
text_080116b8:
        .incbin "frog_us_baserom.gba", 0x000116b8, 0x000001a4
        .size   text_080116b8, . - text_080116b8
