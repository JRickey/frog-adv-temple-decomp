@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023ab4, 0x0802a2f0)  (0x683c bytes)
@
@ Post-peel chunk after sub_080236F4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023ab4
        .type   text_08023ab4, %object
text_08023ab4:
        .incbin "frog_us_baserom.gba", 0x00023ab4, 0x0000683c
        .size   text_08023ab4, . - text_08023ab4
