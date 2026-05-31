@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020d2c, 0x08020dc4)  (0x98 bytes)
@
@ Post-peel chunk after sub_08020CDC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020d2c
        .type   text_08020d2c, %object
text_08020d2c:
        .incbin "frog_us_baserom.gba", 0x00020d2c, 0x00000098
        .size   text_08020d2c, . - text_08020d2c
