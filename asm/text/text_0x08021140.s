@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021140, 0x0802ab64)  (0x9a24 bytes)
@
@ Post-peel chunk after sub_080210A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021140
        .type   text_08021140, %object
text_08021140:
        .incbin "frog_us_baserom.gba", 0x00021140, 0x00009a24
        .size   text_08021140, . - text_08021140
