@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022920, 0x0802ab64)  (0x8244 bytes)
@
@ Post-peel chunk after sub_080228FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022920
        .type   text_08022920, %object
text_08022920:
        .incbin "frog_us_baserom.gba", 0x00022920, 0x00008244
        .size   text_08022920, . - text_08022920
