@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021e34, 0x0802ab64)  (0x8d30 bytes)
@
@ Post-peel chunk after sub_08021CFC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021e34
        .type   text_08021e34, %object
text_08021e34:
        .incbin "frog_us_baserom.gba", 0x00021e34, 0x00008d30
        .size   text_08021e34, . - text_08021e34
