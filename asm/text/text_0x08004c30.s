@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004c30, 0x08004fac)  (0x37c bytes)
@
@ Post-peel chunk after sub_08004C04.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004c30
        .type   text_08004c30, %object
text_08004c30:
        .incbin "frog_us_baserom.gba", 0x00004c30, 0x0000037c
        .size   text_08004c30, . - text_08004c30
