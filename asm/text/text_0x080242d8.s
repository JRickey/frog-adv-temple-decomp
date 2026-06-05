@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080242d8, 0x0802a2f0)  (0x6018 bytes)
@
@ Post-peel chunk after sub_080242AC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080242d8
        .type   text_080242d8, %object
text_080242d8:
        .incbin "frog_us_baserom.gba", 0x000242d8, 0x00006018
        .size   text_080242d8, . - text_080242d8
