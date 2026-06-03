@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023400, 0x0802a394)  (0x6f94 bytes)
@
@ Post-peel chunk after sub_080233D4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023400
        .type   text_08023400, %object
text_08023400:
        .incbin "frog_us_baserom.gba", 0x00023400, 0x00006f94
        .size   text_08023400, . - text_08023400
