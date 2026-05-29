@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020fe4, 0x080210a0)  (0xbc bytes)
@
@ Post-peel chunk after sub_08020F3C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020fe4
        .type   text_08020fe4, %object
text_08020fe4:
        .incbin "frog_us_baserom.gba", 0x00020fe4, 0x000000bc
        .size   text_08020fe4, . - text_08020fe4
