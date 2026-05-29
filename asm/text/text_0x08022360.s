@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022360, 0x0802ab64)  (0x8804 bytes)
@
@ Post-peel chunk after sub_080222BC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022360
        .type   text_08022360, %object
text_08022360:
        .incbin "frog_us_baserom.gba", 0x00022360, 0x00008804
        .size   text_08022360, . - text_08022360
