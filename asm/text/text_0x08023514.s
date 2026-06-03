@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023514, 0x0802a394)  (0x6e80 bytes)
@
@ Post-peel chunk after sub_080234E8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023514
        .type   text_08023514, %object
text_08023514:
        .incbin "frog_us_baserom.gba", 0x00023514, 0x00006e80
        .size   text_08023514, . - text_08023514
