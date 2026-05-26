@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801ea08, 0x08020000)  (0x15f8 bytes)
@
@ Post-peel chunk after sub_0801E28C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801ea08
        .type   text_0801ea08, %object
text_0801ea08:
        .incbin "frog_us_baserom.gba", 0x0001ea08, 0x000015f8
        .size   text_0801ea08, . - text_0801ea08
