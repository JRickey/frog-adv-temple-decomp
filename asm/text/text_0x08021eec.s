@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021eec, 0x0802ab64)  (0x8c78 bytes)
@
@ Post-peel chunk after sub_08021EC0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021eec
        .type   text_08021eec, %object
text_08021eec:
        .incbin "frog_us_baserom.gba", 0x00021eec, 0x00008c78
        .size   text_08021eec, . - text_08021eec
