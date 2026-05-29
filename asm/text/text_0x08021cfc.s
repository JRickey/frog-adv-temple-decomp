@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08021cfc, 0x0802ab64)  (0x8e68 bytes)
@
@ Post-peel chunk after sub_080219BC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08021cfc
        .type   text_08021cfc, %object
text_08021cfc:
        .incbin "frog_us_baserom.gba", 0x00021cfc, 0x00008e68
        .size   text_08021cfc, . - text_08021cfc
