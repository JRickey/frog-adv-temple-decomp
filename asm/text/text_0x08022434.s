@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022434, 0x0802ab64)  (0x8730 bytes)
@
@ Post-peel chunk after sub_08022360.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022434
        .type   text_08022434, %object
text_08022434:
        .incbin "frog_us_baserom.gba", 0x00022434, 0x00008730
        .size   text_08022434, . - text_08022434
