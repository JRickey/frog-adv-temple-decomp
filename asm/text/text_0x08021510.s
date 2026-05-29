@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021510, 0x0802ab64)  (0x9654 bytes)
@
@ Post-peel chunk after sub_08021140.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021510
        .type   text_08021510, %object
text_08021510:
        .incbin "frog_us_baserom.gba", 0x00021510, 0x00009654
        .size   text_08021510, . - text_08021510
