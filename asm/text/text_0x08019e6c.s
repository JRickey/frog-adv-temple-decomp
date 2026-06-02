@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019e6c, 0x08019ef0)  (0x84 bytes)
@
@ Post-peel chunk after sub_08019DB4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019e6c
        .type   text_08019e6c, %object
text_08019e6c:
        .incbin "frog_us_baserom.gba", 0x00019e6c, 0x00000084
        .size   text_08019e6c, . - text_08019e6c
