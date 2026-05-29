@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004d04, 0x08004fac)  (0x2a8 bytes)
@
@ Post-peel chunk after sub_08004CA4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004d04
        .type   text_08004d04, %object
text_08004d04:
        .incbin "frog_us_baserom.gba", 0x00004d04, 0x000002a8
        .size   text_08004d04, . - text_08004d04
