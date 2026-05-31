@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080139f8, 0x08013c60)  (0x268 bytes)
@
@ Post-peel chunk after sub_080139BC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080139f8
        .type   text_080139f8, %object
text_080139f8:
        .incbin "frog_us_baserom.gba", 0x000139f8, 0x00000268
        .size   text_080139f8, . - text_080139f8
