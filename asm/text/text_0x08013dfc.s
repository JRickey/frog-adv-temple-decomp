@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013dfc, 0x08013fa0)  (0x1a4 bytes)
@
@ Post-peel chunk after sub_08013D44.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013dfc
        .type   text_08013dfc, %object
text_08013dfc:
        .incbin "frog_us_baserom.gba", 0x00013dfc, 0x000001a4
        .size   text_08013dfc, . - text_08013dfc
