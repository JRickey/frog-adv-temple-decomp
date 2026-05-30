@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017f00, 0x0801932c)  (0x142c bytes)
@
@ Post-peel chunk after sub_08017DB8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017f00
        .type   text_08017f00, %object
text_08017f00:
        .incbin "frog_us_baserom.gba", 0x00017f00, 0x0000142c
        .size   text_08017f00, . - text_08017f00
