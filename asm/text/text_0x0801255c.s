@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801255c, 0x08012664)  (0x108 bytes)
@
@ Post-peel chunk after sub_0801254C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801255c
        .type   text_0801255c, %object
text_0801255c:
        .incbin "frog_us_baserom.gba", 0x0001255c, 0x00000108
        .size   text_0801255c, . - text_0801255c
