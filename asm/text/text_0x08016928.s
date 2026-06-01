@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08016928, 0x08016a40)  (0x118 bytes)
@
@ Post-peel chunk after sub_080168A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08016928
        .type   text_08016928, %object
text_08016928:
        .incbin "frog_us_baserom.gba", 0x00016928, 0x00000118
        .size   text_08016928, . - text_08016928
