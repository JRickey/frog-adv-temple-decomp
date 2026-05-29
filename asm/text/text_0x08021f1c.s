@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021f1c, 0x0802ab64)  (0x8c48 bytes)
@
@ Post-peel chunk after sub_08021EEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021f1c
        .type   text_08021f1c, %object
text_08021f1c:
        .incbin "frog_us_baserom.gba", 0x00021f1c, 0x00008c48
        .size   text_08021f1c, . - text_08021f1c
