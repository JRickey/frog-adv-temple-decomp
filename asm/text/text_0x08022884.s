@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022884, 0x0802ab64)  (0x82e0 bytes)
@
@ Post-peel chunk after sub_08022838.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022884
        .type   text_08022884, %object
text_08022884:
        .incbin "frog_us_baserom.gba", 0x00022884, 0x000082e0
        .size   text_08022884, . - text_08022884
