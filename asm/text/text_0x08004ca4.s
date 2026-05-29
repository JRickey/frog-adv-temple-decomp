@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004ca4, 0x08004fac)  (0x308 bytes)
@
@ Post-peel chunk after sub_08004C64.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004ca4
        .type   text_08004ca4, %object
text_08004ca4:
        .incbin "frog_us_baserom.gba", 0x00004ca4, 0x00000308
        .size   text_08004ca4, . - text_08004ca4
