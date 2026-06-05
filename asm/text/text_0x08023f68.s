@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023f68, 0x0802a2f0)  (0x6388 bytes)
@
@ Post-peel chunk after sub_08023BC0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023f68
        .type   text_08023f68, %object
text_08023f68:
        .incbin "frog_us_baserom.gba", 0x00023f68, 0x00006388
        .size   text_08023f68, . - text_08023f68
