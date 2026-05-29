@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021ec0, 0x0802ab64)  (0x8ca4 bytes)
@
@ Post-peel chunk after sub_08021E34.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021ec0
        .type   text_08021ec0, %object
text_08021ec0:
        .incbin "frog_us_baserom.gba", 0x00021ec0, 0x00008ca4
        .size   text_08021ec0, . - text_08021ec0
