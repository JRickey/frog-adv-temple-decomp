@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022730, 0x0802ab64)  (0x8434 bytes)
@
@ Post-peel chunk after sub_08022434.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022730
        .type   text_08022730, %object
text_08022730:
        .incbin "frog_us_baserom.gba", 0x00022730, 0x00008434
        .size   text_08022730, . - text_08022730
