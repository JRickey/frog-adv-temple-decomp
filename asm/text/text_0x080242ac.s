@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080242ac, 0x0802a2f0)  (0x6044 bytes)
@
@ Post-peel chunk after sub_08024260.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080242ac
        .type   text_080242ac, %object
text_080242ac:
        .incbin "frog_us_baserom.gba", 0x000242ac, 0x00006044
        .size   text_080242ac, . - text_080242ac
