@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801254c, 0x08012664)  (0x118 bytes)
@
@ Post-peel chunk after sub_080122E4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801254c
        .type   text_0801254c, %object
text_0801254c:
        .incbin "frog_us_baserom.gba", 0x0001254c, 0x00000118
        .size   text_0801254c, . - text_0801254c
