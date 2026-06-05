@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023ff8, 0x0802a2f0)  (0x62f8 bytes)
@
@ Post-peel chunk after sub_08023FAC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023ff8
        .type   text_08023ff8, %object
text_08023ff8:
        .incbin "frog_us_baserom.gba", 0x00023ff8, 0x000062f8
        .size   text_08023ff8, . - text_08023ff8
