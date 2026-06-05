@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023bc0, 0x0802a2f0)  (0x6730 bytes)
@
@ Post-peel chunk after sub_08023AB4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023bc0
        .type   text_08023bc0, %object
text_08023bc0:
        .incbin "frog_us_baserom.gba", 0x00023bc0, 0x00006730
        .size   text_08023bc0, . - text_08023bc0
