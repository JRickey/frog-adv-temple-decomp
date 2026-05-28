@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012cac, 0x08013fa0)  (0x12f4 bytes)
@
@ Post-peel chunk after sub_08012BC4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012cac
        .type   text_08012cac, %object
text_08012cac:
        .incbin "frog_us_baserom.gba", 0x00012cac, 0x000012f4
        .size   text_08012cac, . - text_08012cac
